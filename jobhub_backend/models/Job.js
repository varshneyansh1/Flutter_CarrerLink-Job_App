const mongoose = require("mongoose");

const JobSchema = new mongoose.Schema(
    {
        title: { type: String, required: true},
        location: { type: String, required: true },
        company: { type: String, required: true },
        description: { type: String, required: true },
        salary: { type: String, required: true },
        period: { type: String, required: false, default:"Annum" },
        hiring: { type: Boolean, required: false, default: true },
        contract: { type: String, required: true },
        requirements: {
            type: Array,
            required: true
        },
        imageUrl: {
            type: String,
            required: false,
            default: "https://d326fntlu7tb1e.cloudfront.net/uploads/4821d814-ac87-4b22-aa80-ac7336916c9a-403017_avatar_default_head_person_unknown_icon.png"

        },
        agentId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
            required: false,
        }
    }, { timestamps: true }
);
module.exports = mongoose.model("Job", JobSchema)