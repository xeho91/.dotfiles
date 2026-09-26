import * as v from "valibot";

export { GitleaksFindingSchema };
export type { GitleaksFinding };

const GitleaksFindingSchema = v.object({
	RuleID: v.optional(v.string()),
	Description: v.optional(v.string()),
	Secret: v.optional(v.string()),
	Match: v.optional(v.string()),
});
type GitleaksFinding = v.InferOutput<typeof GitleaksFindingSchema>;
