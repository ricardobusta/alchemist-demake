const id = "BUSTA_EVENT_PLAYER_SET_FIELD";
const groups = ["Busta", "Player Fields", "EVENT_GROUP_VARIABLES"];
const name = "Busta: Update Player Field";

const fields = [
    {
        key: "field",
        label: "Field",
        type: "select",
        defaultValue: "plat_double_jumps",
        options: [
            ["plat_double_jumps", "Number of max double jumps"],
            ["pl_double_jumps", "Amount of double jumps left"]
        ],
    },
    {
        type: "group",
        width: "50%",
        fields: [
            {
                key: "variable",
                type: "variable",
                defaultValue: "LAST_VARIABLE",
                conditions: [
                    {
                        key: "type",
                        eq: "variable",
                    },
                ],
            },
            {
                key: "value",
                type: "number",
                defaultValue: 0,
                min: 0,
                max: 255,
                conditions: [
                    {
                        key: "type",
                        eq: "number",
                    },
                ],
            },
            {
                key: "type",
                type: "selectbutton",
                options: [
                    ["variable", "variable"],
                    ["number", "number"],
                ],
                inline: true,
                defaultValue: "number",
            },
        ],
    },
];

const compile = (input, helpers) => {
    const { _addComment, _addNL, _setConstMemInt16, _setMemInt16ToVariable } =
        helpers;

    if (input.type === "variable") {
        _addComment("Busta Set Field To Variable");
        _setMemInt16ToVariable(input.field, input.variable);
    } else {
        _addComment("Busta Set Field To Value");
        _setConstMemInt16(input.field, input.value);
    }
    _addNL();
};

module.exports = {
    id,
    name,
    groups,
    fields,
    compile,
    allowedBeforeInitFade: true,
};