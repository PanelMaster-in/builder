import fs from "fs";
import path from "path";

const supported = ["7.4", "8.0", "8.1", "8.2", "8.3", "8.4", "8.5"];

// Read existing manifest as fallback
const manifestPath = path.join(process.cwd(), "manifests/php.json");
let existingManifest = {};
if (fs.existsSync(manifestPath)) {
  try {
    existingManifest = JSON.parse(fs.readFileSync(manifestPath, "utf8"));
  } catch (e) {
    console.warn("Could not parse existing php.json manifest", e);
  }
}

async function fetchLatestFromGitHub(branch) {
  // Query tags from the official php-src repository
  const res = await fetch(
    `https://api.github.com/repos/php/php-src/tags?per_page=100`,
    {
      headers: {
        "User-Agent": "node-fetch",
        Accept: "application/vnd.github.v3+json",
      },
    }
  );
  if (!res.ok) {
    throw new Error(`GitHub API Error ${res.status}`);
  }
  const tags = await res.json();
  const versions = tags
    .map((tag) => tag.name)
    .filter((name) => name.startsWith(`php-${branch}.`))
    .map((name) => name.replace(/^php-/, ""))
    // Match only standard stable versions (e.g. 8.3.23, exclude alpha/beta/RC)
    .filter((version) => /^\d+\.\d+\.\d+$/.test(version))
    .sort((a, b) => a.localeCompare(b, undefined, { numeric: true }));

  return versions.pop();
}

async function main() {
  const manifest = {};

  // Fetch the tags page once to optimize API requests
  let tags = [];
  try {
    const res = await fetch(
      `https://api.github.com/repos/php/php-src/tags?per_page=100`,
      {
        headers: {
          "User-Agent": "node-fetch",
          Accept: "application/vnd.github.v3+json",
        },
      }
    );
    if (res.ok) {
      tags = await res.json();
    } else {
      console.warn(`GitHub API returned status ${res.status}, falling back to local registry`);
    }
  } catch (err) {
    console.warn("Failed to fetch tags from GitHub, falling back to local registry:", err.message);
  }

  for (const branch of supported) {
    // Filter versions matching this branch from retrieved tags
    const versions = tags
      .map((tag) => tag.name)
      .filter((name) => name.startsWith(`php-${branch}.`))
      .map((name) => name.replace(/^php-/, ""))
      .filter((version) => /^\d+\.\d+\.\d+$/.test(version))
      .sort((a, b) => a.localeCompare(b, undefined, { numeric: true }));

    const latestTag = versions.pop();
    if (latestTag) {
      manifest[branch] = latestTag;
      console.log(`Discovered latest version for ${branch}: ${latestTag}`);
    } else {
      manifest[branch] = existingManifest[branch] || null;
      console.log(`No active tags found for branch ${branch} in recent feed, using fallback: ${manifest[branch]}`);
    }
  }

  // Clean nulls from final output if we don't even have a fallback
  for (const key of Object.keys(manifest)) {
    if (manifest[key] === null) {
      delete manifest[key];
    }
  }

  fs.mkdirSync("manifests", { recursive: true });
  fs.writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));
  console.log("PHP Version Discovery complete:");
  console.log(manifest);
}

main();
