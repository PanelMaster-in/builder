import fs from "fs";

const supported = ["7.4", "8.0", "8.1", "8.2", "8.3", "8.4", "8.5"];

async function latest(branch) {
  const major = branch.split(".")[0];

  const res = await fetch(
    `https://www.php.net/releases/index.php?json&version=${major}`,
  );

  const data = await res.json();

  const versions = Object.keys(data)
    .filter((v) => v.startsWith(branch))
    .sort((a, b) => a.localeCompare(b, undefined, { numeric: true }));

  return versions.pop();
}

const manifest = {};

for (const branch of supported) {
  try {
    manifest[branch] = await latest(branch);
  } catch {
    console.log(`Unable to fetch ${branch}`);
  }
}

fs.mkdirSync("manifests", { recursive: true });

fs.writeFileSync("manifests/php.json", JSON.stringify(manifest, null, 2));

console.log(manifest);
