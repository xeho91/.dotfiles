import fs from "node:fs";
import process from "node:process";

import { getEncoding, type TiktokenEncoding } from "js-tiktoken";

function usage(): never {
	console.error("Usage: node count-tokens.ts <file> [encoding]");
	process.exit(2);
}

const [filePath, encodingName = "o200k_base", ...extraArgs] = process.argv.slice(2) as [
	string,
	TiktokenEncoding,
	...string[],
];

if (!filePath || extraArgs.length > 0) {
	usage();
}

try {
	const text = fs.readFileSync(filePath, "utf8");
	const encoding = getEncoding(encodingName);
	const lines = text.split(/\r\n|\n|\r/);

	if (lines.at(-1) === "" && lines.length > 1) {
		lines.pop();
	}

	console.log(`file: ${filePath}`);
	console.log(`encoding: ${encodingName}`);
	console.log(`lines: ${text.length === 0 ? 0 : lines.length}`);
	console.log(`words: ${text.trim() === "" ? 0 : text.trim().split(/\s+/u).length}`);
	console.log(`characters: ${Array.from(text).length}`);
	console.log(`bytes: ${Buffer.byteLength(text, "utf8")}`);
	console.log(`tokens: ${encoding.encode(text).length}`);
} catch (err) {
	const message = Error.isError(err) ? err.message : String(err);
	console.error(`Could not count tokens: ${message}`);
	process.exitCode = 1;
}
