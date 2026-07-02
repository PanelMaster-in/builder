import fs from "fs";
import path from "path";

const repo = process.env.GITHUB_REPOSITORY || "ghostcompiler/flyenv-php-builder";
const token = process.env.GITHUB_TOKEN;

async function fetchReleases() {
  const url = `https://api.github.com/repos/${repo}/releases`;
  const headers = {
    "User-Agent": "node-fetch",
    Accept: "application/vnd.github.v3+json",
  };
  if (token) {
    headers["Authorization"] = `token ${token}`;
  }

  const res = await fetch(url, { headers });
  if (!res.ok) {
    throw new Error(`Failed to fetch releases: ${res.statusText}`);
  }
  return await res.json();
}

function parseAsset(name, browser_download_url) {
  // Patterns:
  // Core: php-8.3.23-macos-arm64.tar.gz, php-8.3.23-windows-x64.zip
  // Ext: ext-8.3.23-redis-macos-arm64.tar.gz
  const isExt = name.startsWith("ext-");
  if (isExt) {
    const match = name.match(/^ext-([\d.]+)-([a-zA-Z0-9_]+)-([a-zA-Z0-9]+)-([a-zA-Z0-9]+)\.(tar\.gz|zip)$/);
    if (match) {
      return {
        type: "extension",
        phpVersion: match[1],
        extName: match[2],
        os: match[3],
        arch: match[4],
        url: browser_download_url,
        filename: name,
      };
    }
  } else {
    const match = name.match(/^php-([\d.]+)-([a-zA-Z0-9]+)-([a-zA-Z0-9]+)\.(tar\.gz|zip)$/);
    if (match) {
      return {
        type: "core",
        phpVersion: match[1],
        os: match[2],
        arch: match[3],
        url: browser_download_url,
        filename: name,
      };
    }
  }
  return null;
}

async function main() {
  console.log(`Fetching releases for ${repo}...`);
  let releases = [];
  if (process.env.MOCK_RELEASES === "true") {
    console.log("Using mock release data for local testing...");
    releases = [
      {
        tag_name: "v8.4.10",
        assets: [
          { name: "php-8.4.10-macos-x64.tar.gz", browser_download_url: "https://github.com/mock/releases/download/v8.4.10/php-8.4.10-macos-x64.tar.gz" },
          { name: "php-8.4.10-macos-arm64.tar.gz", browser_download_url: "https://github.com/mock/releases/download/v8.4.10/php-8.4.10-macos-arm64.tar.gz" },
          { name: "php-8.4.10-linux-x64.tar.gz", browser_download_url: "https://github.com/mock/releases/download/v8.4.10/php-8.4.10-linux-x64.tar.gz" },
          { name: "php-8.4.10-linux-arm64.tar.gz", browser_download_url: "https://github.com/mock/releases/download/v8.4.10/php-8.4.10-linux-arm64.tar.gz" },
          { name: "php-8.4.10-windows-x64.zip", browser_download_url: "https://github.com/mock/releases/download/v8.4.10/php-8.4.10-windows-x64.zip" },
          { name: "ext-8.4.10-redis-macos-arm64.tar.gz", browser_download_url: "https://github.com/mock/releases/download/v8.4.10/ext-8.4.10-redis-macos-arm64.tar.gz" },
          { name: "ext-8.4.10-redis-linux-x64.tar.gz", browser_download_url: "https://github.com/mock/releases/download/v8.4.10/ext-8.4.10-redis-linux-x64.tar.gz" },
          { name: "ext-8.4.10-xdebug-windows-x64.zip", browser_download_url: "https://github.com/mock/releases/download/v8.4.10/ext-8.4.10-xdebug-windows-x64.zip" }
        ]
      },
      {
        tag_name: "v8.3.23",
        assets: [
          { name: "php-8.3.23-macos-arm64.tar.gz", browser_download_url: "https://github.com/mock/releases/download/v8.3.23/php-8.3.23-macos-arm64.tar.gz" },
          { name: "php-8.3.23-linux-x64.tar.gz", browser_download_url: "https://github.com/mock/releases/download/v8.3.23/php-8.3.23-linux-x64.tar.gz" },
          { name: "php-8.3.23-windows-x64.zip", browser_download_url: "https://github.com/mock/releases/download/v8.3.23/php-8.3.23-windows-x64.zip" },
          { name: "ext-8.3.23-redis-macos-arm64.tar.gz", browser_download_url: "https://github.com/mock/releases/download/v8.3.23/ext-8.3.23-redis-macos-arm64.tar.gz" },
          { name: "ext-8.3.23-xdebug-macos-arm64.tar.gz", browser_download_url: "https://github.com/mock/releases/download/v8.3.23/ext-8.3.23-xdebug-macos-arm64.tar.gz" }
        ]
      }
    ];
  } else {
    try {
      releases = await fetchReleases();
    } catch (error) {
      console.error("Error fetching releases:", error);
      process.exit(1);
    }
  }

  // Group by PHP Version
  const phpGroups = {};

  for (const release of releases) {
    const version = release.tag_name.replace(/^v/, "");
    if (!phpGroups[version]) {
      phpGroups[version] = {
        version,
        core: {},
        extensions: {},
      };
    }

    for (const asset of release.assets) {
      const parsed = parseAsset(asset.name, asset.browser_download_url);
      if (!parsed) continue;

      const platformKey = `${parsed.os}-${parsed.arch}`;
      if (parsed.type === "core") {
        phpGroups[version].core[platformKey] = parsed.url;
      } else if (parsed.type === "extension") {
        if (!phpGroups[version].extensions[parsed.extName]) {
          phpGroups[version].extensions[parsed.extName] = {};
        }
        phpGroups[version].extensions[parsed.extName][platformKey] = parsed.url;
      }
    }
  }

  const sortedVersions = Object.keys(phpGroups).sort((a, b) =>
    b.localeCompare(a, undefined, { numeric: true })
  );

  let markdown = "";

  if (sortedVersions.length === 0) {
    markdown = "\n*No compiled releases are registered yet. The build pipeline will generate downloads on release execution.*\n";
  } else {
    for (const ver of sortedVersions) {
      const group = phpGroups[ver];
      markdown += `\n### PHP ${ver}\n\n`;
      
      // Core runtimes table
      markdown += `#### Base Runtimes\n\n`;
      markdown += `| OS | Architecture | File Format | Download Link |\n`;
      markdown += `| :--- | :--- | :--- | :--- |\n`;
      
      const platforms = [
        { name: "macOS", os: "macos", arch: "x64", format: "tar.gz" },
        { name: "macOS", os: "macos", arch: "arm64", format: "tar.gz" },
        { name: "Linux", os: "linux", arch: "x64", format: "tar.gz" },
        { name: "Linux", os: "linux", arch: "arm64", format: "tar.gz" },
        { name: "Windows", os: "windows", arch: "x64", format: "zip" },
        { name: "Windows", os: "windows", arch: "arm64", format: "zip" },
      ];

      for (const p of platforms) {
        const key = `${p.os}-${p.arch}`;
        const url = group.core[key];
        const downloadLabel = url ? `[Download php-${ver}-${p.os}-${p.arch}.${p.format}](${url})` : "*Not built yet*";
        markdown += `| **${p.name}** | \`${p.arch}\` | \`.${p.format}\` | ${downloadLabel} |\n`;
      }
      
      markdown += `\n`;

      // Extensions table if any exist
      const extNames = Object.keys(group.extensions).sort();
      if (extNames.length > 0) {
        markdown += `#### Dynamic Extensions (PECL / Shared)\n\n`;
        markdown += `| Extension | macOS x64 | macOS ARM64 | Linux x64 | Linux ARM64 | Windows x64 | Windows ARM64 |\n`;
        markdown += `| :--- | :---: | :---: | :---: | :---: | :---: | :---: |\n`;
        
        for (const ext of extNames) {
          const links = [];
          for (const p of platforms) {
            const key = `${p.os}-${p.arch}`;
            const url = group.extensions[ext][key];
            links.push(url ? `[⬇️ Link](${url})` : "-");
          }
          markdown += `| **${ext}** | ${links.join(" | ")} |\n`;
        }
        markdown += `\n`;
      }
      markdown += `***\n`;
    }
  }

  // Read README.md and replace
  const readmePath = path.join(process.cwd(), "README.md");
  if (!fs.existsSync(readmePath)) {
    console.error("README.md not found!");
    process.exit(1);
  }

  const content = fs.readFileSync(readmePath, "utf8");
  const startTag = "<!-- START_RELEASES_TABLE -->";
  const endTag = "<!-- END_RELEASES_TABLE -->";

  const startIndex = content.indexOf(startTag);
  const endIndex = content.indexOf(endTag);

  if (startIndex === -1 || endIndex === -1) {
    console.error("Release table comments not found in README.md");
    process.exit(1);
  }

  const updatedContent =
    content.substring(0, startIndex + startTag.length) +
    "\n" +
    markdown.trim() +
    "\n" +
    content.substring(endIndex);

  fs.writeFileSync(readmePath, updatedContent, "utf8");
  console.log("README.md releases table updated successfully!");
}

main();
