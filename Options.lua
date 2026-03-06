local L = LibStub("AceLocale-3.0"):GetLocale("MythicPlusUtility")

MythicPlusUtility.defaults = {
    global = {minimap = {hide = false}},
    profile = {
        toggleFrameLock = true,
        hideOnStart = true,
        frameWidth = 350,
        frameHeight = 600,
        frameXOffset = 100,
        frameYOffset = -150,
        frameBackground = {r = 0, g = 0, b = 0, a = 0.5},
        buttonSize = 35,
        labelFontSize = 12,
        textFontSize = 12,
        dungeonNameSize = 20,
        hideNotImportant = false,
        instanceID = MythicPlusUtility.defaultDungeonId,
        selectFramePoint = "TOPLEFT",
        difficultyID = {[1] = false, [2] = false, [23] = true},

        buttonCosmetic = {
            ['**'] = {
                enabled = true,
                iconDesaturate = false,
                iconColor = {r = 255, g = 255, b = 255, a = 1},
                iconGlow = false,
                iconGlowColor = {r = 255, g = 255, b = 255, a = 1},
                label = "",
                labelKey = "default",
                labelList = {},
                labelListOrder = {"default", "defaultText", "none", "custom"},
                isCustom = false,
                labelFont = "",
                labelSize = 12,
                labelColor = {r = 0, g = 0, b = 0, a = 1},
                customLabelType = "text",
                customLabelTypeList = {text = L["Text"], atlas = L["AtlasID Texture"], icon = L["Icon"]},
                customLabelTypeListOrder = {"text", "icon", "atlas"},
                customLabelText = "",
                customLabelAtlas = "",
                customLabelAtlasFormatted = "",
                customLabelIcon = "",
                customLabelIconFormatted = "",
            },
            unlearnAbility = {
                iconColor = {r = 255, g = 0, b = 0, a = 1},
                iconGlowColor = {r = 255, g = 0, b = 0, a = 1},
                label = "-",
                labelList = {default = "-", defaultText = L["Remove"], none = L["None"], custom = L["Custom"]},
                labelColor = {r = 255, g = 0, b = 0, a = 1},
            },
            needAbility = {
                iconDesaturate = true,
                iconGlowColor = {r = 0, g = 255, b = 0, a = 1},
                label = "+",
                labelList = {default = "+", defaultText = L["Add"], none = L["None"], custom = L["Custom"]},
                labelColor = {r = 0, g = 255, b = 0, a = 1},
            },
            onlyNotImportantAbility = {
                iconGlowColor = {r = 255, g = 255, b = 0, a = 1},
                label = "?",
                labelList = {default = "?", defaultText = L["Optional"], none = L["None"], custom = L["Custom"]},
                labelColor = {r = 255, g = 255, b = 0, a = 1},
            },
            NeedOnlyNotImportantAbility = {
                iconGlowColor = {r = 191, g = 255, b = 0, a = 1},
                label = "+?",
                labelList = {default = "+?", defaultText = L["Add Optional"], none = L["None"], custom = L["Custom"]},
                labelColor = {r = 191, g = 255, b = 0, a = 1},
            },
            learnedAbility = {
                enabled = false,
                label = "✓",
                labelList = {default = "✓", defaultText = L["Known"], none = L["None"], custom = L["Custom"]},
            },
        },
    },
}

MythicPlusUtility.options = {
    type = "group",
    name = "Mythic Plus Utility",
    handler = MythicPlusUtility,
    childGroups = "tab",
    args = {
        toggleFrame = {type = "execute", order = 1, name = L["Toggle Window"], func = "ToggleAbilitiesFrame"},
        breakLine1 = {type = "header", order = 10, name = ""},
        breakLine2 = {type = "header", order = 20, name = ""},
        frameGroup = {
            type = "group",
            order = 1,
            name = L["Window Position and Size Settings"],
            args = {
                frameWidth = {
                    type = "range",
                    order = 1,
                    name = L["Width"],
                    get = "GetValue",
                    set = function(info, value)
                        MythicPlusUtility.db.profile[info[#info]] = value
                        if MythicPlusUtility.Frame then
                            MythicPlusUtility.Frame:SetWidth(value)
                            MythicPlusUtility.Frame:UpdateTextWrap()
                        end
                    end,
                    min = 150,
                    softMax = 1000,
                    bigStep = 5,
                },
                frameHeight = {
                    type = "range",
                    order = 2,
                    name = L["Height"],
                    get = "GetValue",
                    set = function(info, value)
                        MythicPlusUtility.db.profile[info[#info]] = value
                        if MythicPlusUtility.Frame then MythicPlusUtility.Frame:SetHeight(value) end
                    end,
                    min = 150,
                    softMax = 1000,
                    bigStep = 5,
                },
                breakLine1 = {type = "header", order = 10, name = ""},
                toggleFrameLock = {
                    type = "toggle",
                    order = 12,
                    name = L["Lock Window"],
                    get = "GetValue",
                    set = "SetValue",
                },
                selectFramePoint = {
                    type = "select",
                    order = 11,
                    name = L["Anchor to Screen's"],
                    get = "GetValue",
                    set = "SetValueUpdatePosition",
                    sorting = {
                        "TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "CENTER", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT",
                    },
                    values = {
                        TOPLEFT = "TOPLEFT",
                        TOP = "TOP",
                        TOPRIGHT = "TOPRIGHT",
                        LEFT = "LEFT",
                        CENTER = "CENTER",
                        RIGHT = "RIGHT",
                        BOTTOMLEFT = "BOTTOMLEFT",
                        BOTTOM = "BOTTOM",
                        BOTTOMRIGHT = "BOTTOMRIGHT",
                    },
                },
                breakLine2 = {type = "header", order = 20, name = ""},
                frameXOffset = {
                    type = "range",
                    order = 21,
                    name = L["X Offset"],
                    get = "GetValue",
                    set = "SetValueUpdatePosition",
                    softMin = -2500,
                    softMax = 2500,
                    bigStep = 5,
                },
                frameYOffset = {
                    type = "range",
                    order = 22,
                    name = L["Y Offset"],
                    get = "GetValue",
                    set = "SetValueUpdatePosition",
                    softMin = -2500,
                    softMax = 2500,
                    bigStep = 5,
                },
            },
        },
        textGroup = {
            type = "group",
            order = 2,
            name = L["Text and Icon Size Settings"],
            args = {
                buttonSize = {
                    type = "range",
                    order = 11,
                    name = L["Icon Size"],
                    get = "GetValue",
                    set = "SetValueUpdateButtonSize",
                    min = 10,
                    softMax = 100,
                    step = 1,
                    bigStep = 5,
                },
                labelFontSize = {
                    type = "range",
                    order = 12,
                    name = L["Icon Label Size"],
                    get = "GetValue",
                    set = "SetValueUpdateFont",
                    min = 1,
                    softMin = 5,
                    softMax = 40,
                    step = 1,
                },
                textFontSize = {
                    type = "range",
                    order = 2,
                    name = L["Body Text Size"],
                    get = "GetValue",
                    set = "SetValueUpdateFont",
                    min = 1,
                    softMin = 5,
                    softMax = 40,
                    step = 1,
                },
                dungeonNameSize = {
                    type = "range",
                    order = 1,
                    name = L["Dungeon Name Size"],
                    get = "GetValue",
                    set = "SetValueUpdateFont",
                    min = 1,
                    softMin = 5,
                    softMax = 40,
                    step = 1,
                },
                breakLine1 = {type = "header", order = 10, name = ""},
            },
        },
        frameBackground = {
            type = "color",
            hasAlpha = true,
            order = 12,
            name = L["Background Color"],
            get = function(info)
                local t = MythicPlusUtility.db.profile[info[#info]]
                return t.r, t.g, t.b, t.a
            end,
            set = function(info, r, g, b, a)
                MythicPlusUtility.db.profile[info[#info]] = {r = r, g = g, b = b, a = a}
                if MythicPlusUtility.Frame then
                    MythicPlusUtility.Frame.background:SetColorTexture(r, g, b, a)
                end
            end,
        },
        hideOnStart = {
            type = "toggle",
            order = 2,
            width = 2,
            name = L["Hide on Mythic+ start"],
            get = "GetValue",
            set = "SetValue",
        },
        hideNotImportant = {
            type = "toggle",
            order = 21,
            name = L["Hide not Important"],
            desc = format(L["Hides dungeon entries that are marked with %s"],
                          CreateAtlasMarkup("map-icon-ignored-bluequestion")),
            get = "GetValue",
            set = "SetValueChangeInstance",
        },
        difficultyID = {
            type = "multiselect",
            order = 13,
            name = L["Show in"],
            get = "GetValueDifficulty",
            set = "SetValueDifficulty",
            values = {[1] = L["Normal"], [2] = L["Heroic"], [23] = L["Mythic"]},
        },
        instanceID = {
            type = "select",
            order = 11,
            name = L["Dungeon Preview"],
            get = "GetValueInstance",
            set = "SetValueInstance",
            sorting = {2526, 2811, 2874, 123, 658, 1753, 1209, 2805},
            values = MythicPlusUtility.dungeonIdToName,
        },
        buttonCosmeticGroup = {
            type = "group",
            childGroups = "tree",
            order = 3,
            name = L["Icon Cosmetics Settings"],
            args = {
                learnedAbility = {
                    type = "group",
                    inline = "true",
                    order = 1,
                    name = L[""],
                    get = "GetValueButtonCosmetic",
                    set = "SetValueButtonCosmetic",
                    args = {
                        enabled = {type = "toggle", order = 1, name = L["Enable"]},
                        iconDesaturate = {type = "toggle", order = 2, name = L["Desaturate"]},
                        iconColor = {
                            type = "color",
                            desc = L["Set as white (#FFFFFF) to not change icon color"],
                            order = 3,
                            name = L["Icon Color"],
                            get = "GetValueButtonCosmeticColor",
                            set = "SetValueButtonCosmeticColor",
                        },
                        iconGlow = {type = "toggle", order = 4, name = L["Enable Icon Glow"]},
                        -- iconGlowColor = ,
                        -- label = "",
                        -- labelKey = "default",
                        labelList = {
                            type = "select",
                            order = 6,
                            name = L["Shown Text"],
                            get = "GetValueButtonCosmeticTextType",
                            set = "SetValueButtonCosmeticTextType",
                            sorting = MythicPlusUtility.db.profile.buttonCosmetic.learnedAbility.labelListOrder,
                            values = MythicPlusUtility.db.profile.buttonCosmetic.learnedAbility.labelList,
                        },
                        -- isCustom = false,
                        labelFont = {
                            type = "select",
                            order = 7,
                            name = L["Font"],
                            get = "GetValueButtonCosmeticFont",
                            set = "SetValueButtonCosmeticFont",
                            values = MythicPlusUtility.fontList,
                        },
                        labelSize = {
                            type = "range",
                            order = 8,
                            name = L["Text Size"],
                            min = 1,
                            softMin = 5,
                            softMax = 40,
                            step = 1,
                        },
                        labelColor = {
                            type = "color",
                            order = 9,
                            name = L["Text Color"],
                            get = "GetValueButtonCosmeticColor",
                            set = "SetValueButtonCosmeticColor",
                        },
                        customLabelType = {
                            type = "select",
                            order = 10,
                            name = L["Custom Text Type"],
                            get = "GetValueButtonCosmeticTextType",
                            set = "SetValueButtonCosmeticTextType",
                            sorting = MythicPlusUtility.db.profile.buttonCosmetic.learnedAbility
                              .customLabelTypeListOrder,
                            values = MythicPlusUtility.db.profile.buttonCosmetic.learnedAbility.customLabelTypeList,
                        },
                        customLabelText = {type = "input", order = 11, name = L["Custom Text"]},
                        customLabelIcon = {
                            type = "input",
                            order = 11,
                            name = L["Custom Icon Texture"],
                            desc = L["Write Icon Id here, multiple ids can be entered with ; delimenter."],
                            set = "SetValueButtonCosmeticCustomIcon",
                        },
                        -- customLabelIconFormatted = "",
                        customLabelAtlas = {
                            type = "input",
                            order = 11,
                            name = L["Custom Atlas Texture"],
                            desc = L["Write Atlas Name here, multiple names can be entered with ; delimenter. I recommend finding Atlas Names with TextureAtlasViewer addon."],
                            set = "SetValueButtonCosmeticCustomAtlas",
                        },
                        -- customLabelAtlasFormatted = "",
                    },
                },
            },
        },
    },
}

function MythicPlusUtility:GetValue(info) return self.db.profile[info[#info]] end

function MythicPlusUtility:SetValue(info, value) self.db.profile[info[#info]] = value end

function MythicPlusUtility:SetValueUpdatePosition(info, value)
    self.db.profile[info[#info]] = value
    if self.Frame then self.Frame:UpdatePosition() end
end
function MythicPlusUtility:SetValueUpdateFont(info, value)
    self.db.profile[info[#info]] = value
    if self.Frame then self.Frame:UpdateFont() end
end
function MythicPlusUtility:SetValueUpdateButtonSize(info, value)
    self.db.profile[info[#info]] = value
    if self.Frame then self.Frame:UpdateButtonSize() end
end

function MythicPlusUtility:GetValueInstance(info)
    return self.dungeonIdToName[self.db.profile.instanceID] and self.db.profile.instanceID or self.defaultDungeonId
end

function MythicPlusUtility:SetValueInstance(info, value)
    self.db.profile.instanceID = value
    if self.Frame then self.Frame:ChangeInstance() end
end

function MythicPlusUtility:GetValueDifficulty(info, key) return self.db.profile.difficultyID[key] end

function MythicPlusUtility:SetValueDifficulty(info, key, state) self.db.profile.difficultyID[key] = state end
