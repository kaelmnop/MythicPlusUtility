local L = LibStub("AceLocale-3.0"):GetLocale("MythicPlusUtility")
local LSM = LibStub and LibStub("LibSharedMedia-3.0", true)

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
                iconColor = {r = 1, g = 1, b = 1, a = 1},
                iconGlow = false,
                iconGlowType = "pixel",
                iconGlowColor = {r = 1, g = 1, b = 1, a = 1},
                glowPixelN = 8,
                glowPixelFrequency = 0.25,
                glowPixelLength = 0,
                glowPixelTh = 2,
                glowPixelXOffset = 0,
                glowPixelYOffset = 0,
                glowPixelBorder = false,
                glowAutocastN = 4,
                glowAutocastFrequency = 0.125,
                glowAutocastScale = 1,
                glowAutocastXOffset = 0,
                glowAutocastYOffset = 0,
                glowButtonFrequency = 0.125,
                label = "",
                labelType = "default",
                isCustom = false,
                labelColor = {r = 0, g = 0, b = 0, a = 1},
                labelSize = 12,
                labelFont = "Friz Quadrata TT",
                labelOutline = "OUTLINE",
                labelShadow = false,
                labelShadowColor = {r = 0, g = 0, b = 0, a = 1},
                labelShadowX = 1,
                labelShadowY = -1,
                customLabelType = "text",
                customLabelText = "",
                customLabelAtlas = "",
                customLabelAtlasFormatted = "",
                customLabelIcon = "",
                customLabelIconFormatted = "",
            },
            unlearnAbility = {
                iconColor = {r = 1, g = 0, b = 0, a = 1},
                iconGlowColor = {r = 1, g = 0, b = 0, a = 1},
                label = "-",
                labelColor = {r = 1, g = 0, b = 0, a = 1},
            },
            needAbility = {
                iconDesaturate = true,
                iconGlowColor = {r = 0, g = 1, b = 0, a = 1},
                label = "+",
                labelColor = {r = 0, g = 1, b = 0, a = 1},
            },
            onlyNotImportantAbility = {
                iconGlowColor = {r = 1, g = 1, b = 0, a = 1},
                label = "?",
                labelColor = {r = 1, g = 1, b = 0, a = 1},
            },
            needOnlyNotImportantAbility = {
                iconGlowColor = {r = 0.75, g = 1, b = 0, a = 1},
                label = "+?",
                labelColor = {r = 0.75, g = 1, b = 0, a = 1},
            },
            learnedAbility = {enabled = false, label = "*"},
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
                    inline = false,
                    order = 1,
                    name = "Learned Ability",
                    get = "GetValueButtonCosmetic",
                    set = "SetValueButtonCosmetic",
                    args = {
                        enabled = {type = "toggle", order = 1, name = L["Enable"]},
                        iconDesaturate = {
                            type = "toggle",
                            order = 1.1,
                            name = L["Desaturate Icon"],
                            hidden = "ButtonCosmeticHide",
                        },
                        iconColor = {
                            type = "color",
                            desc = L["Set as white (#FFFFFF) to not change icon color"],
                            order = 1.2,
                            name = L["Icon Color"],
                            hidden = "ButtonCosmeticHide",
                            get = "GetValueButtonCosmeticColor",
                            set = "SetValueButtonCosmeticColor",
                        },
                        -- Glow Settings
                        glowBreakLine = {
                            type = "header",
                            order = 2,
                            name = L["Glow Settings"],
                            hidden = "ButtonCosmeticHide",
                        },
                        iconGlow = {
                            type = "toggle",
                            order = 2.1,
                            name = L["Enable"],
                            width = 0.8,
                            hidden = "ButtonCosmeticHide",
                        },
                        iconGlowType = {
                            type = "select",
                            order = 2.2,
                            name = L["Glow Type"],
                            width = 0.8,
                            hidden = "ButtonCosmeticHide",
                            sorting = MythicPlusUtility.globals.glowTypeOrder,
                            values = MythicPlusUtility.globals.glowType,
                        },
                        iconGlowColor = {
                            type = "color",
                            order = 2.3,
                            name = L["Glow Color"],
                            width = 0.8,
                            hidden = "ButtonCosmeticHide",
                            get = "GetValueButtonCosmeticColor",
                            set = "SetValueButtonCosmeticColor",
                        },

                        -- Pixel Glow
                        glowPixelN = {
                            type = "range",
                            order = 2.4,
                            name = L["Number of lines"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            min = 1,
                            softMin = 1,
                            softMax = 20,
                            step = 1,
                        },
                        glowPixelFrequency = {
                            type = "range",
                            order = 2.5,
                            name = L["Frequency"],
                            desc = L["Set to negative to inverse direction of rotation"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            softMin = -1,
                            softMax = 1,
                            bigStep = 0.05,
                        },
                        glowPixelLength = {
                            type = "range",
                            order = 2.6,
                            name = L["Length of lines"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            min = 0,
                            softMax = 20,
                            step = 1,
                        },
                        glowPixelTh = {
                            type = "range",
                            order = 2.7,
                            name = L["Thickness of lines"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            min = 0,
                            softMax = 20,
                            step = 1,
                        },
                        glowPixelXOffset = {
                            type = "range",
                            order = 2.8,
                            name = L["X Offset"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            softMin = -10,
                            softMax = 10,
                            step = 1,
                        },
                        glowPixelYOffset = {
                            type = "range",
                            order = 2.9,
                            name = L["Y Offset"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            softMin = -10,
                            softMax = 10,
                            step = 1,
                        },
                        glowPixelBorder = {
                            type = "toggle",
                            order = 2.91,
                            name = L["Border"],
                            width = 0.8,
                            hidden = "ButtonCosmeticHide",
                        },
                        -- Autocast Glow
                        glowAutocastN = {
                            type = "range",
                            order = 2.4,
                            name = L["Number of lines"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            min = 1,
                            softMin = 1,
                            softMax = 20,
                            step = 1,
                        },
                        glowAutocastFrequency = {
                            type = "range",
                            order = 2.5,
                            name = L["Frequency"],
                            desc = L["Set to negative to inverse direction of rotation"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            softMin = -1,
                            softMax = 1,
                            bigStep = 0.005,
                        },
                        glowAutocastScale = {
                            type = "range",
                            order = 2.6,
                            name = L["Scale"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            min = 0,
                            softMax = 10,
                            step = 1,
                        },
                        glowAutocastXOffset = {
                            type = "range",
                            order = 2.7,
                            name = L["X Offset"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            softMin = -10,
                            softMax = 10,
                            step = 1,
                        },
                        glowAutocastYOffset = {
                            type = "range",
                            order = 2.8,
                            name = L["Y Offset"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            softMin = -10,
                            softMax = 10,
                            step = 1,
                        },
                        -- Button Glow
                        glowButtonFrequency = {
                            type = "range",
                            order = 2.4,
                            name = L["Frequency"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            softMin = -1,
                            softMax = 1,
                            bigStep = 0.005,
                        },

                        -- Text Settings
                        labelBreakLine = {
                            type = "header",
                            order = 3,
                            name = L["Text Settings"],
                            hidden = "ButtonCosmeticHide",
                        },
                        -- label = "",
                        labelType = {
                            type = "select",
                            order = 3.1,
                            name = L["Shown Text"],
                            width = 0.8,
                            hidden = "ButtonCosmeticHide",
                            sorting = MythicPlusUtility.globals.labelListOrder,
                            values = MythicPlusUtility.globals.learnedAbility.labelList,
                        },
                        labelSize = {
                            type = "range",
                            order = 3.2,
                            name = L["Text Size"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            min = 1,
                            softMin = 5,
                            softMax = 40,
                            step = 1,
                        },
                        labelColor = {
                            type = "color",
                            order = 3.3,
                            width = 0.8,
                            name = L["Text Color"],
                            hidden = "ButtonCosmeticHide",
                            get = "GetValueButtonCosmeticColor",
                            set = "SetValueButtonCosmeticColor",
                        },
                        labelOutline = {
                            type = "select",
                            order = 3.4,
                            name = L["Outline"],
                            width = 0.8,
                            hidden = "ButtonCosmeticHide",
                            sorting = {'NONE', 'MONOCHROME', 'OUTLINE', 'THICKOUTLINE'},
                            values = {
                                NONE = "None",
                                MONOCHROME = "Monochrome",
                                OUTLINE = "Thin",
                                THICKOUTLINE = "Thick",
                            },
                        },
                        labelFont = {
                            type = "select",
                            dialogControl = 'LSM30_Font',
                            order = 3.5,
                            name = L["Font"],
                            hidden = "ButtonCosmeticHide",
                            values = LSM:HashTable("font"),
                        },
                        -- Shadow
                        labelShadowBreakLine = {
                            type = "header",
                            order = 4,
                            name = L["Shadow Settings"],
                            hidden = "ButtonCosmeticHide",
                        },
                        labelShadow = {
                            type = "toggle",
                            order = 4.1,
                            name = L["Enable"],
                            width = 0.8,
                            hidden = "ButtonCosmeticHide",
                        },
                        labelShadowColor = {
                            type = "color",
                            order = 4.2,
                            name = L["Shadow Color"],
                            width = 0.8,
                            hidden = "ButtonCosmeticHide",
                            get = "GetValueButtonCosmeticColor",
                            set = "SetValueButtonCosmeticColor",
                        },
                        labelShadowX = {
                            type = "range",
                            order = 4.3,
                            name = L["X Offset"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            softMin = -10,
                            softMax = 10,
                            step = 1,
                        },
                        labelShadowY = {
                            type = "range",
                            order = 4.4,
                            name = L["Y Offset"],
                            width = 0.7,
                            hidden = "ButtonCosmeticHide",
                            softMin = -10,
                            softMax = 10,
                            step = 1,
                        },
                        -- Custom Label
                        customLabelBreakLine = {
                            type = "header",
                            order = 5,
                            name = L["Custom Text Settings"],
                            hidden = "ButtonCosmeticHide",
                        },
                        customLabelType = {
                            type = "select",
                            order = 5.1,
                            name = L["Custom Text Type"],
                            hidden = "ButtonCosmeticHide",
                            sorting = MythicPlusUtility.globals.customLabelTypeListOrder,
                            values = MythicPlusUtility.globals.customLabelTypeList,
                        },
                        customLabelText = {
                            type = "input",
                            order = 5.2,
                            name = L["Custom Text"],
                            hidden = "ButtonCosmeticHide",
                        },
                        customLabelIcon = {
                            type = "input",
                            order = 5.2,
                            name = L["Custom Icon Texture"],
                            hidden = "ButtonCosmeticHide",
                            desc = L["Write Icon Id here, multiple ids can be entered with ; delimenter."],
                            set = "SetValueButtonCosmeticCustomIcon",
                        },
                        -- customLabelIconFormatted = "",
                        customLabelAtlas = {
                            type = "input",
                            order = 5.2,
                            name = L["Custom Atlas Texture"],
                            hidden = "ButtonCosmeticHide",
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

function MythicPlusUtility:GetValueButtonCosmetic(info)
    return self.db.profile.buttonCosmetic[info[#info - 1]][info[#info]]
end

function MythicPlusUtility:SetValueButtonCosmetic(info, value)
    local name = info[#info]
    local db = self.db.profile.buttonCosmetic[info[#info - 1]]

    db[name] = value
    if name == "labelType" then
        local label = ""
        db.isCustom = value == "custom"
        if value == "default" or value == "defaultText" then
            label = MythicPlusUtility.globals[info[#info - 1]].labelList[value]
        end
        db.label = label
    elseif name == "customLabelIcon" then
        -- customLabelIconFormatted set
    elseif name == "customLabelAtlas" then
        -- customLabelAtlasFormatted set
    end

    if MythicPlusUtility.Frame then

        if name == "enabled" then
            -- update everything function
        elseif name == "iconDesaturate" then
            -- update only icon function
        elseif name == "iconGlow" then
            -- update only icon glow function
        elseif name == "labelType" or name == "labelSize" then
            -- update text and layout
        elseif name == "labelOutline" or name == "labelFont" then
            -- update text font and layout
        elseif name == "labelShadow" or name == "labelShadowX" or name == "labelShadowY" then
            -- update text shadow
        elseif name == "customLabelType" or name == "customLabelText" or name == "customLabelIcon" or name
          == "customLabelAtlas" then
            -- update text and layout
        elseif name == 'iconGlow' or name == 'iconGlowType' or name == 'glowPixelN' or name == 'glowPixelFrequency'
          or name == 'glowPixelLength' or name == 'glowPixelTh' or name == 'glowPixelXOffset' or name
          == 'glowPixelYOffset' or name == 'glowPixelBorder' or name == 'glowAutocastN' or name
          == 'glowAutocastFrequency' or name == 'glowAutocastScale' or name == 'glowAutocastXOffset' or name
          == 'glowAutocastYOffset' or name == 'glowButtonFrequency' then
            -- update glow function
        end

    end
end

function MythicPlusUtility:GetValueButtonCosmeticColor(info)
    local t = self.db.profile.buttonCosmetic[info[#info - 1]][info[#info]]
    return t.r, t.g, t.b, t.a
end

function MythicPlusUtility:SetValueButtonCosmeticColor(info, r, g, b, a)
    local name = info[#info]
    local db = self.db.profile.buttonCosmetic[info[#info - 1]]

    db[name] = {r = r, g = g, b = b, a = a}
    if MythicPlusUtility.Frame then
        if name == "iconColor" then
            -- update only icon function
        elseif name == "iconGlowColor" then
            -- update only icon glow function
        elseif name == "labelShadowColor" then
            -- update text shadow, no layout
        end
    end
end

function MythicPlusUtility:ButtonCosmeticHide(info)
    local name = info[#info]
    local db = self.db.profile.buttonCosmetic[info[#info - 1]]
    local enabled = not db.enabled

    if name == "iconGlowColor" or name == "iconGlowType" then
        return enabled or not db.iconGlow

    elseif name == "labelFont" or name == "labelSize" or name == "labelColor" or name == "labelOutline" or name
      == "labelShadowBreakLine" or name == "labelShadow" then
        return enabled or db.labelType == "none"

    elseif name == "labelShadowX" or name == "labelShadowY" or name == "labelShadowColor" then
        return enabled or db.labelType == "none" or not db.labelShadow

    elseif name == 'glowPixelN' or name == 'glowPixelFrequency' or name == 'glowPixelLength' or name == 'glowPixelTh'
      or name == 'glowPixelXOffset' or name == 'glowPixelYOffset' or name == 'glowPixelBorder' then
        return enabled or not db.iconGlow or db.iconGlowType ~= "pixel"

    elseif name == 'glowAutocastN' or name == 'glowAutocastFrequency' or name == 'glowAutocastScale' or name
      == 'glowAutocastXOffset' or name == 'glowAutocastYOffset' then
        return enabled or not db.iconGlow or db.iconGlowType ~= "autocast"

    elseif name == "customLabelBreakLine" or name == "customLabelType" then
        return enabled or not db.isCustom

    elseif name == "customLabelText" then
        return enabled or not db.isCustom or db.customLabelType ~= "text"

    elseif name == "customLabelIcon" then
        return enabled or not db.isCustom or db.customLabelType ~= "icon"

    elseif name == "customLabelAtlas" then
        return enabled or not db.isCustom or db.customLabelType ~= "atlas"

    end

    return enabled

end
