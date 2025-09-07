-- サービス --
local WebhookURL = "https://discord.com/api/webhooks/1412192013268287508/j7LtLIFD0OjcbISfjt9Rtm7Pc90_TA5Pm5uIMKe2y70YCsDfmug1sSctq04tGMOWSS69"
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local startTime = tick()
local warningCount = 0
local warningLimit = 10
local banMessageWait = 3
local timestamp = os.date("%Y/%m/%d %H:%M:%S")
local count = 0
local feedbackText = ""
local bannedWords = {
    "fuck","fuk","nigger","nigga","bitch","shit","asshole","retard",
    "gay","lesbian","dumb","stupid","idiot","die","suicide",
    "しね","死ね","きえろ","消えろ","バカ","アホ","カス","ゴミ","雑魚",
    "ころす","殺す","殺害","くず","低能","ブス","デブ",
    "aaa","bbb","ccc","test","spam","うんこ","くそ",
    "a","b","c","d","e","1","2","3"
}
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/yua20170313a-pixel/Orion/e19e8236bde46c459fb0d617e4640aeb75878703/source')))()
game.StarterGui:SetCore("SendNotification", {
    Title = "ロード";
    Text = "ロード中...";
    Duration = 5;
})
wait(2)
while tick() - startTime < 1 do
    for i = 1, 1000000 do
        count = count + math.sqrt(i) * math.random()
    end
end
game.StarterGui:SetCore("SendNotification", {
    Title = "ロード";
    Text = "ロード完了。";
    Duration = 5;
})

-- ウィンドウ作成
local Window = OrionLib:MakeWindow({Name = "Folse Hub By Hackv2", HidePremium = false, SaveConfig = true, IntroEnabled = true, IntroText = "ようこそ。", IntroIcon = "rbxassetid://79190396225189", Icon = "rbxassetid://79190396225189", ConfigFolder = "BetaHub"})

-- 関数 --
function AddParagraph(tab, titleText, content)
    return tab:AddParagraph("【" .. titleText .. "】", content)
end

-- 通知関数（音付き）
local function ShowNotification(title, content, image, state)
    OrionLib:MakeNotification({
        Name = title or "通知",
        Content = content or "",
        Image = image or "rbxassetid://17208372272",
        Time = 4
    })
    local sound = Instance.new("Sound")
    sound.Parent = SoundService
    sound.Volume = 3
    if state == true then
        sound.SoundId = "rbxassetid://11312409703" -- 成功音
    elseif state == false then
        sound.SoundId = "rbxassetid://8530043932" -- 失敗音
    end
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

local function SendUserInfo()
    local timestamp = os.date("%Y/%m/%d %H:%M:%S")
    local data = {
    ["content"] = "**ユーザー情報ログ**\n"
                .. "👤 ユーザー名: `" .. LocalPlayer.Name .. "`\n"
                .. "🆔 UserId: `" .. LocalPlayer.UserId .. "`\n"
                .. "📅 アカウント日数: `" .. LocalPlayer.AccountAge .. "日`\n"
                .. "🔗 プロフィール: https://www.roblox.com/users/" .. LocalPlayer.UserId .. "/profile\n"
                .. "⏰ 送信時刻: `" .. timestamp .. "`"
}
    local success, err = pcall(function()
        http_request({
            Url = WebhookURL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(data)
        })
    end)

    if not success then
        warn("ユーザー情報送信失敗: " .. tostring(err))
    end
end

-- 成功通知
local function NotifyYes(title, text)
    ShowNotification(title, text, "rbxassetid://11312409703", true)
end

-- 失敗通知
local function NotifyNo(title, text)
    ShowNotification(title, text, "rbxassetid://8530043932", false)
end

-- 確認通知
local function NotifyCheck(title, text)
    ShowNotification(title, text, "rbxassetid://134569085797091", true)
end
-- Toogle通知
function NotifyToggle(name, state)
    if state then
        NotifyYes(name, name .. ": 有効")
    else
        NotifyNo(name, name .. ": 無効")
    end
end
-- 注意ラベル
function AddNoticeLabel(tab, text)
    return tab:AddLabel("⚠️ " .. text)
end
SendUserInfo()
task.spawn(function()
    while task.wait(180) do
        SendUserInfo()
    end
end)

-- ホーム --
local HomeTab = Window:MakeTab({
	Name = "ホーム",
	Icon = "rbxassetid://13060262529",
	PremiumOnly = false
})
AddParagraph(HomeTab, "UI／Orion", "Orion Library 改造版 by Hackv2(@HfSapSatu)")
AddParagraph(HomeTab, "ホーム科目", "Folseハブへようこそ。スプリクトをご利用していただきありがとうございます。")

AddParagraph(HomeTab, "情報ログ", "スプリクトアップデート&修正")
AddParagraph(HomeTab, "スプリクトアップデート", "【2025/09/01】│ [<<初期リリース>>]")
AddParagraph(HomeTab, "スプリクト修正", "【2025/09/01】│ [<<初期リリース>>]")

AddParagraph(HomeTab, "クレジット", "クレジットなど")
AddParagraph(HomeTab, "クレジットTikTok", "【TikTok-< JA [@logfeetst】")
AddParagraph(HomeTab, "クレジットRoblox", "【Roblox-< Hackv2 [@HfSapSatu】")
-- Sky --
local SkyTab = Window:MakeTab({
	Name = "空",
	Icon = "rbxassetid://6413875420",
	PremiumOnly = false
})

-- 空表示トグル
SkyTab:AddToggle({
    Name = "空を表示",
    Default = false,
    Callback = function(Value)
        NotifyToggle("空を表示", Value)
        if Value then
            if not game.Lighting:FindFirstChild("CustomSky") then
                local sky = Instance.new("Sky")
                sky.Name = "CustomSky"
                sky.SkyboxBk = "rbxassetid://12345678"
                sky.SkyboxDn = "rbxassetid://12345678"
                sky.SkyboxFt = "rbxassetid://12345678"
                sky.SkyboxLf = "rbxassetid://12345678"
                sky.SkyboxRt = "rbxassetid://12345678"
                sky.SkyboxUp = "rbxassetid://12345678"
                sky.Parent = game.Lighting
            end
        else
            if game.Lighting:FindFirstChild("CustomSky") then
                game.Lighting.CustomSky:Destroy()
            end
        end
    end
})

-- 時間帯スライダー
SkyTab:AddSlider({
	Name = "時間帯",
	Min = 0,
	Max = 24,
	Default = 12,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "時間",
	Callback = function(Value)
		if not _G.UseRealTime then
			game.Lighting.TimeOfDay = string.format("%02d:00:00", Value)
		end
	end    
})

-- 現在の時間帯トグル
SkyTab:AddToggle({
    Name = "現在の時間帯に同期",
    Default = false,
    Callback = function(Value)
        NotifyToggle("現在の時間帯に同期", Value)
        _G.UseRealTime = Value
        if Value then
            spawn(function()
                while _G.UseRealTime do
                    local hour = os.date("*t").hour
                    local min = os.date("*t").min
                    game.Lighting.TimeOfDay = string.format("%02d:%02d:00", hour, min)
                    wait(60) -- 1分ごとに更新
                end
            end)
        end
    end
})
-- FeedBack --
local FeedBackTab = Window:MakeTab({
    Name = "フィードバック",
    Icon = "rbxassetid://106726324368958",
    PremiumOnly = false
})
local function isInvalidFeedback(text)
    if text == nil or text == "" then
        return true
    end
    if #text < 2 then
        return true
    end
    local lower = string.lower(text)
    for _, word in ipairs(bannedWords) do
        if string.find(lower, word) then
            return true
        end
    end
    return false
end
FeedBackTab:AddTextbox({
    Name = "フィードバック:意見",
    Default = "意見",
    TextDisappear = false,
    Callback = function(Value)
        feedbackText = Value
    end
})
FeedBackTab:AddButton({
    Name = "送信する",
    Callback = function()
        if isInvalidFeedback(feedbackText) then
            warningCount = warningCount + 1
            NotifyNo("警告", "禁止ワードや短すぎる文字列は送信できません。 (" .. warningCount .. "/" .. warningLimit .. ")")
            if warningCount >= warningLimit then
                local timestamp = os.date("%Y/%m/%d %H:%M:%S")
                local data = {
                    ["content"] = "**ユーザーKick報告**\n"
                                .. "👤 ユーザー: `" .. LocalPlayer.Name .. "`\n"
                                .. "🆔 UserId: `" .. LocalPlayer.UserId .. "`\n"
                                .. "⚠️ 理由: フィードバックで警告10回\n"
                                .. "⚠️ 警告回数: `" .. warningCount .. "/" .. warningLimit .. "`\n"
                                .. "⏰ Kick時刻: `" .. timestamp .. "`\n"
                                .. "🔗 プロフィール: https://www.roblox.com/users/" .. LocalPlayer.UserId .. "/profile\n"
                                .. "⚠️ 再参加: このプレイヤーは再参加時も同じKick通知を送ります"
                }
                pcall(function()
                    http_request({
                        Url = WebhookURL,
                        Method = "POST",
                        Headers = {["Content-Type"] = "application/json"},
                        Body = HttpService:JSONEncode(data)
                    })
                end)
                LocalPlayer:Kick("警告が10回を超えたためBanされました。 " .. banMessageWait .. "分後にお試しください。")
            end
            return
        end
        NotifyCheck("送信中", "Discord に送信しています...")
        local data = {
            ["content"] = "**新しいフィードバック**\n"
                        .. "👤 ユーザー: `" .. LocalPlayer.Name .. "`\n"
                        .. "🆔 UserId: `" .. LocalPlayer.UserId .. "`\n"
                        .. "💬 内容: " .. feedbackText .. "\n"
                        .. "⏰ 送信時刻: `" .. timestamp .. "`"
        }
        local success, err = pcall(function()
            http_request({
                Url = WebhookURL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode(data)
            })
        end)
        if success then
            NotifyYes("送信完了", "Discord に送信されました！")
            feedbackText = ""
        else
            NotifyNo("[デバッグ] エラー", "送信失敗: " .. tostring(err))
        end
    end
})
AddNoticeLabel(FeedBackTab, "注意: 荒らしワードや1文字は禁止されています。")
AddNoticeLabel(FeedBackTab, "注意: すべてのフェードバックは開発者,管理者,Discordに送られます。")
FeedBackTab:AddLabel("Discord招待リンク:https://discord.gg/9jVbgsUaM6")
-- キーそうさ
local UITab = Window:MakeTab({
    Name = "キー操作",
    Icon = "rbxassetid://7034135855",
    PremiumOnly = false
})

-- 1. UI表示/非表示
UITab:AddBind({
    Name = "UI表示切替",
    Default = Enum.KeyCode.U,
    Hold = false,
    Callback = function()
        if OrionLib:IsVisible() then
            OrionLib:Hide()
            NotifyNo("UI", "UIを非表示にしました")
        else
            OrionLib:Show()
            NotifyYes("UI", "UIを表示しました")
        end
    end
})

-- 2. 空表示切替
UITab:AddBind({
    Name = "Sky表示切替",
    Default = Enum.KeyCode.T,
    Hold = false,
    Callback = function()
        local sky = game.Lighting:FindFirstChild("CustomSky")
        if sky then
            sky:Destroy()
            NotifyNo("Sky", "空を非表示にしました")
        else
            local newSky = Instance.new("Sky")
            newSky.Name = "CustomSky"
            newSky.SkyboxBk = "rbxassetid://12345678"
            newSky.SkyboxDn = "rbxassetid://12345678"
            newSky.SkyboxFt = "rbxassetid://12345678"
            newSky.SkyboxLf = "rbxassetid://12345678"
            newSky.SkyboxRt = "rbxassetid://12345678"
            newSky.SkyboxUp = "rbxassetid://12345678"
            newSky.Parent = game.Lighting
            NotifyYes("Sky", "空を表示しました")
        end
    end
})

-- 3. 時間同期ON/OFF
UITab:AddBind({
    Name = "時間同期切替",
    Default = Enum.KeyCode.Y,
    Hold = false,
    Callback = function()
        _G.UseRealTime = not _G.UseRealTime
        if _G.UseRealTime then
            NotifyYes("時間同期", "現在時刻に同期ON")
        else
            NotifyNo("時間同期", "現在時刻に同期OFF")
        end
    end
})

-- 4. フィードバック送信
UITab:AddBind({
    Name = "フィードバック送信",
    Default = Enum.KeyCode.F,
    Hold = false,
    Callback = function()
        if isInvalidFeedback(feedbackText) then
            NotifyNo("フィードバック", "内容が無効です")
        else
            FeedBackTab:FindFirstChild("送信する").Callback(feedbackText)
            NotifyYes("フィードバック", "送信しました")
        end
    end
})


-- 5. Skyを朝に設定
UITab:AddBind({
    Name = "朝に設定",
    Default = Enum.KeyCode.One,  -- 1キー
    Hold = false,
    Callback = function()
        game.Lighting.TimeOfDay = "06:00:00"
        NotifyYes("時間設定", "朝に設定しました")
    end
})

-- 6. Skyを昼に設定
UITab:AddBind({
    Name = "昼に設定",
    Default = Enum.KeyCode.Two,  -- 2キー
    Hold = false,
    Callback = function()
        game.Lighting.TimeOfDay = "12:00:00"
        NotifyYes("時間設定", "昼に設定しました")
    end
})

-- 7. Skyを夕方に設定
UITab:AddBind({
    Name = "夕方に設定",
    Default = Enum.KeyCode.Three,  -- 3キー
    Hold = false,
    Callback = function()
        game.Lighting.TimeOfDay = "18:00:00"
        NotifyYes("時間設定", "夕方に設定しました")
    end
})

-- 8. Skyを夜に設定
UITab:AddBind({
    Name = "夜に設定",
    Default = Enum.KeyCode.Four,  -- 4キー
    Hold = false,
    Callback = function()
        game.Lighting.TimeOfDay = "23:00:00"
        NotifyYes("時間設定", "夜に設定しました")
    end
})
-- 9. UIをリロード
UITab:AddBind({
    Name = "UIリロード",
    Default = Enum.KeyCode.R,
    Hold = false,
    Callback = function()
        OrionLib:Destroy()
        NotifyYes("UI", "UIをリロードしました")
    end
})

-- 10. 警告テスト
UITab:AddBind({
    Name = "警告通知",
    Default = Enum.KeyCode.Q,
    Hold = false,
    Callback = function()
        NotifyNo("警告", "これはテスト警告です")
    end
})

-- 11. 成功通知テスト
UITab:AddBind({
    Name = "成功通知",
    Default = Enum.KeyCode.W,
    Hold = false,
    Callback = function()
        NotifyYes("成功", "これはテスト成功通知です")
    end
})

-- 12. 確認通知テスト
UITab:AddBind({
    Name = "確認通知",
    Default = Enum.KeyCode.E,
    Hold = false,
    Callback = function()
        NotifyCheck("確認", "これはテスト確認通知です")
    end
})

-- 13. フィードバック警告リセット
UITab:AddBind({
    Name = "警告リセット",
    Default = Enum.KeyCode.Z,
    Hold = false,
    Callback = function()
        warningCount = 0
        NotifyYes("警告", "警告カウントをリセットしました")
    end
})

-- 14. Skybox全削除
UITab:AddBind({
    Name = "全Sky削除",
    Default = Enum.KeyCode.X,
    Hold = false,
    Callback = function()
        local sky = game.Lighting:FindFirstChild("CustomSky")
        if sky then sky:Destroy() end
        NotifyNo("Sky", "全Skyを削除しました")
    end
})

-- 15. デバッグ通知
UITab:AddBind({
    Name = "デバッグ通知",
    Default = Enum.KeyCode.C,
    Hold = false,
    Callback = function()
        NotifyCheck("デバッグ", "テスト通知です")
    end
})

-- 16. アカウント情報送信
UITab:AddBind({
    Name = "ユーザー情報送信",
    Default = Enum.KeyCode.V,
    Hold = false,
    Callback = function()
        SendUserInfo()
        NotifyYes("送信", "ユーザー情報を送信しました")
    end
})

-- 17. サウンド再生1
UITab:AddBind({
    Name = "サウンド1",
    Default = Enum.KeyCode.B,
    Hold = false,
    Callback = function()
        local sound = Instance.new("Sound", SoundService)
        sound.SoundId = "rbxassetid://11312409703"
        sound.Volume = 3
        sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end
})

-- 18. サウンド再生2
UITab:AddBind({
    Name = "サウンド2",
    Default = Enum.KeyCode.N,
    Hold = false,
    Callback = function()
        local sound = Instance.new("Sound", SoundService)
        sound.SoundId = "rbxassetid://8530043932"
        sound.Volume = 3
        sound:Play()
        sound.Ended:Connect(function() sound:Destroy() end)
    end
})

-- 19. Skyランダム切替
UITab:AddBind({
    Name = "Skyランダム",
    Default = Enum.KeyCode.M,
    Hold = false,
    Callback = function()
        local sky = game.Lighting:FindFirstChild("CustomSky")
        if not sky then
            sky = Instance.new("Sky")
            sky.Parent = game.Lighting
        end
        sky.SkyboxBk = "rbxassetid://"..tostring(math.random(1000000,9999999))
        sky.SkyboxDn = "rbxassetid://"..tostring(math.random(1000000,9999999))
        sky.SkyboxFt = "rbxassetid://"..tostring(math.random(1000000,9999999))
        sky.SkyboxLf = "rbxassetid://"..tostring(math.random(1000000,9999999))
        sky.SkyboxRt = "rbxassetid://"..tostring(math.random(1000000,9999999))
        sky.SkyboxUp = "rbxassetid://"..tostring(math.random(1000000,9999999))
        sky.Name = "CustomSky"
        NotifyYes("Sky", "Skyをランダムに変更しました")
    end
})
-- 20. 全通知テスト
UITab:AddBind({
    Name = "全通知テスト",
    Default = Enum.KeyCode.P,
    Hold = false,
    Callback = function()
        NotifyYes("成功", "成功通知")
        NotifyNo("失敗", "失敗通知")
        NotifyCheck("確認", "確認通知")
    end
})

OrionLib:Init()
