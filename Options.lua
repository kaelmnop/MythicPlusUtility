local L = LibStub("AceLocale-3.0"):GetLocale("MythicPlusUtility")

MythicPlusUtility.defaults = {
    profile = {
        toggleFrameLock = true,
        hideOnStart = true,
        frameWidth = 350,
        frameHeight = 600,
        frameXOffset = 100,
        frameYOffset = -150,
        frameBackgroundAlpha = 0.5,
        buttonSize = 35,
        labelFontSize = 12,
        textFontSize = 12,
        hideNotImportant = false,
        instanceID = 2526,
        selectFramePoint = "TOPLEFT",
        difficultyID = {[1] = false, [2] = false, [23] = true},
    },
}

-- https://www.wowace.com/projects/ace3/pages/ace-config-3-0-options-tables
MythicPlusUtility.options = {
    type = "group",
    name = "Mythic Plus Utility",
    handler = MythicPlusUtility,
    childGroups = "tab",
    args = {
        toggleFrame = {type = "execute", order = 1, name = L["Toggle Frame"], func = "ToggleAbilitiesFrame"},
        breakLine1 = {type = "header", order = 10, name = ""},
        breakLine2 = {type = "header", order = 20, name = ""},
        frameGroup = {
            type = "group",
            order = 1,
            name = L["Frame Position and Size Settings"],
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
                            MythicPlusUtility.Frame:UpdateLayout()
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
                    name = L["Lock Frame"],
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
                    order = 1,
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
                    order = 2,
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
                    order = 11,
                    name = L["Body Text Size"],
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
        frameBackgroundAlpha = {
            type = "range",
            order = 12,
            name = L["Background Opacity"],
            get = "GetValue",
            set = function(info, value)
                MythicPlusUtility.db.profile[info[#info]] = value
                if MythicPlusUtility.Frame then
                    MythicPlusUtility.Frame.background:SetColorTexture(0, 0, 0, value)
                end
            end,
            min = 0,
            max = 1,
            step = 0.01,
            bigStep = 0.1,
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
            get = "GetValue",
            set = "SetValueChangeInstance",
            sorting = {2526, 2811, 2874, 123, 658, 1753, 1209, 2805},
            values = {
                [2526] = L["Algeth\'ar Academy"],
                [2811] = L["Magisters\' Terrace"],
                [2874] = L["Maisara Caverns"],
                [123] = L["Nexus-Point Xenas"],
                [658] = L["Pit of Saron"],
                [1753] = L["Seat of the Triumvirate"],
                [1209] = L["Skyreach"],
                [2805] = L["Windrunner Spire"],
            },
        },
    },
}

-- for documentation on the info table
-- https://www.wowace.com/projects/ace3/pages/ace-config-3-0-options-tables#title-4-1
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

function MythicPlusUtility:SetValueChangeInstance(info, value)
    self.db.profile[info[#info]] = value
    if self.Frame then self.Frame:ChangeInstance() end
end

function MythicPlusUtility:GetValueDifficulty(info, key) return self.db.profile.difficultyID[key] end

function MythicPlusUtility:SetValueDifficulty(info, key, state) self.db.profile.difficultyID[key] = state end
