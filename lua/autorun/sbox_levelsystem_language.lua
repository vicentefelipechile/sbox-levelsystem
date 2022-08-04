-- https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes

CreateConVar("sbox_ls_lang", "en", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The language to use for the level system.")
local lang = GetConVar("sbox_ls_lang")
local lang_table = {
    ["en"] = "english",
    ["es"] = "spanish"
}

function SLS.GetLanguage(phrase)
    local language = lang_table[lang:GetString()] or "english"
    return sbox_ls.language[language][phrase] or phrase
end