using { /Fortnite.com/Devices}
using { /Verse.org/Simulation}
using { /UnrealEngine.com/Temporary/UI}
using { /Fortnite.com/UI}
using { /UnrealEngine.com/Temporary/SpatialMath}

passcode := class<concrete>:
    @editable PIN : int = 0
    @editable Trigger : ?trigger_device = false

 

PinPad := class(creative_device):

    @editable Passcodes : []passcode = array{}
    # ボタンのデバイスをエディタ内で設定し、ゲーム内でそのデバイスを参照できるようにする
    @editable
    MyButton : button_device = button_device{}
    
    # UI にテキストとして表示するローカライズ可能なメッセージ
    TextForMyUI<localizes>(InText : string) : message = "{InText}"

    # プレイヤーと、そのプレイヤーの UI に追加されている可能性のあるウィジェットとのマッピング
    var MaybeMyUIPerPlayer : [player]?tuple(canvas,button_regular,string) = map{}

    # ゲーム実行時にこのデバイスが初期化されたときに実行される処理
    OnBegin<override>()<suspends> : void =
        MyButton.InteractedWithEvent.Subscribe(HandleButtonInteraction)

    # UI は特定のプレイヤーに紐付けて表示させることができる
    HandleButtonInteraction(Agent : agent) : void =
        # agent はプレイヤーまたは AI だが、UI を取得できるのはプレイヤーのみのため、
        # 対象がプレイヤーであることをキャストして確認する必要がある
        if (InPlayer := player[Agent], PlayerUI := GetPlayerUI[InPlayer]):

            NewUI := CreateMyUI()
            PlayerUI.AddWidget(NewUI(0), player_ui_slot{InputMode := ui_input_mode.All})
            if (set MaybeMyUIPerPlayer[InPlayer] = option{(NewUI(0),NewUI(1),"")}) {}
    
    # テキスト付きのボタンを画面の各位置に表示するキャンバスウィジェットを生成する
    CreateMyUI() : tuple(canvas, button_regular) =
        # 数字ボタンを定義する
        UpperLeft  : button_loud = button_loud{DefaultText := TextForMyUI("1")}
        UpperMiddle : button_loud = button_loud{DefaultText := TextForMyUI("2")}
        UpperRight : button_loud = button_loud{DefaultText := TextForMyUI("3")}
        MiddleLeft : button_loud = button_loud{DefaultText := TextForMyUI("4")}
        Center : button_loud = button_loud{DefaultText := TextForMyUI("5")}
        MiddleRight : button_loud = button_loud{DefaultText := TextForMyUI("6")}
        LowerLeft : button_loud = button_loud{DefaultText := TextForMyUI("7")}
        LowerMiddle : button_loud = button_loud{DefaultText := TextForMyUI("8")}
        LowerRight : button_loud = button_loud{DefaultText := TextForMyUI("9")}
        Lower : button_loud = button_loud{DefaultText := TextForMyUI("0")}
        BackSpace : button_loud = button_loud{DefaultText := TextForMyUI("◀️")}
        Clear : button_loud = button_loud{DefaultText := TextForMyUI("C")}
        closeKey : button_quiet = button_quiet{DefaultText := TextForMyUI("Close")}
        enterKey : button_quiet = button_quiet{DefaultText := TextForMyUI("Enter")}
        text : button_regular = button_regular{DefaultText := TextForMyUI("")}
        # 各ボタンがクリックされたときの処理を登録する
        UpperLeft.OnClick().Subscribe(HandleSelectedUIButton)
        UpperMiddle.OnClick().Subscribe(HandleSelectedUIButton)
        UpperRight.OnClick().Subscribe(HandleSelectedUIButton)
        MiddleLeft.OnClick().Subscribe(HandleSelectedUIButton)
        Center.OnClick().Subscribe(HandleSelectedUIButton)
        MiddleRight.OnClick().Subscribe(HandleSelectedUIButton)
        LowerLeft.OnClick().Subscribe(HandleSelectedUIButton)
        LowerMiddle.OnClick().Subscribe(HandleSelectedUIButton)
        LowerRight.OnClick().Subscribe(HandleSelectedUIButton)
        Lower.OnClick().Subscribe(HandleSelectedUIButton)
        BackSpace.OnClick().Subscribe(HandleSelectedUIButtonBackSpace)
        Clear.OnClick().Subscribe(HandleSelectedUIButtonClear)
        closeKey.OnClick().Subscribe(HandleSelectedUIButtonClose)
        enterKey.OnClick().Subscribe(HandleSelectedUIButtonEnter)
        MyCanvas : canvas = canvas:
            Slots := array:
                canvas_slot: # 画面左上
                    Anchors := anchors{Minimum := vector2{X := 0.45, Y := 0.4}, Maximum := vector2{X := 0.45, Y := 0.4}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.45, Y := 0.4}
                    SizeToContent := true
                    Widget := UpperLeft
                canvas_slot: # 画面中央上
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.4}, Maximum := vector2{X := 0.5, Y := 0.4} }
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.4}
                    SizeToContent := true
                    Widget := UpperMiddle
                canvas_slot: # 画面右上
                    Anchors := anchors{Minimum := vector2{X := 0.55, Y := 0.4}, Maximum := vector2{X := 0.55, Y := 0.4}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.55, Y := 0.4}
                    SizeToContent := true
                    Widget := UpperRight
                canvas_slot: # 画面左中央
                    Anchors := anchors{ Minimum := vector2{X := 0.45, Y := 0.5}, Maximum := vector2{X := 0.45, Y := 0.5}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.45, Y := 0.5}
                    SizeToContent := true
                    Widget := MiddleLeft
                canvas_slot: # 画面中央
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := true
                    Widget := Center
                canvas_slot: # 画面右中央
                    Anchors := anchors{Minimum := vector2{X := 0.55, Y := 0.5}, Maximum := vector2{X := 0.55, Y := 0.5}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.55, Y := 0.5}
                    SizeToContent := true
                    Widget := MiddleRight
                canvas_slot: # 画面左下
                    Anchors := anchors{Minimum := vector2{X := 0.45, Y := 0.6}, Maximum := vector2{X := 0.45, Y := 0.6}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.45, Y := 0.6}
                    SizeToContent := true
                    Widget := LowerLeft
                canvas_slot: # 画面中央下
                    Anchors := anchors{ Minimum := vector2{X := 0.5, Y := 0.6}, Maximum := vector2{X := 0.5, Y := 0.6}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.6}
                    SizeToContent := true
                    Widget :=  LowerMiddle
                canvas_slot: # 画面右下
                    Anchors := anchors{Minimum := vector2{X := 0.55, Y := 0.6}, Maximum := vector2{X := 0.55, Y := 0.6}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.55, Y := 0.6}
                    SizeToContent := true
                    Widget := LowerRight
                canvas_slot: # 画面下
                    Anchors := anchors{ Minimum := vector2{X := 0.5, Y := 0.7}, Maximum := vector2{X := 0.5, Y := 0.7}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.7}
                    SizeToContent := true
                    Widget := Lower
                canvas_slot: #1文字削除（BackSpace）
                    Anchors := anchors{Minimum := vector2{X := 0.55, Y := 0.7}, Maximum := vector2{X := 0.55, Y := 0.7}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.55, Y := 0.7}
                    SizeToContent := true
                    Widget := BackSpace
                canvas_slot: # 入力全消去（Clear）
                    Anchors := anchors{Minimum := vector2{X := 0.45, Y := 0.7}, Maximum := vector2{X := 0.45, Y := 0.7}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.45, Y := 0.7}
                    SizeToContent := true
                    Widget := Clear
                canvas_slot: # 閉じる
                    Anchors := anchors{Minimum := vector2{X := 0.41, Y := 0.74}, Maximum := vector2{X := 0.495, Y := 0.8}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.45, Y := 0.8}
                    SizeToContent := true
                    Widget := closeKey
                canvas_slot: #確定（Enter）
                    Anchors := anchors{Minimum := vector2{X := 0.505, Y := 0.74}, Maximum := vector2{X := 0.59, Y := 0.8}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.55, Y := 0.8}
                    SizeToContent := true
                    Widget := enterKey
                canvas_slot: # テキストの背景として使用（テキストをボタン化）
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.29}, Maximum := vector2{X := 0.5, Y := 0.35}}
                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.35}
                    SizeToContent := true
                    Widget := text
        return (MyCanvas,text)

    HandleSelectedUIButton(Message : widget_message) : void = # 数字ボタンが押されたときの処理
        if (SelectedButton := text_button_base[Message.Source]):
            if(UIState:=MaybeMyUIPerPlayer[Message.Player]?):
                var CurrentInput:string=UIState(2)
                set CurrentInput += SelectedButton.GetText()
                if(set MaybeMyUIPerPlayer[Message.Player] = option{(UIState(0),UIState(1),CurrentInput)}){}
                UpdateUI(Message)
    
    HandleSelectedUIButtonClose(Message : widget_message) : void = # 閉じるボタンが押されたときの処理
        if(UIState:=MaybeMyUIPerPlayer[Message.Player]?):
            UpdatedString : string = ""
            if(set MaybeMyUIPerPlayer[Message.Player] = option{(UIState(0),UIState(1),UpdatedString)}){}
            RemovePinPad(Message.Player)
    HandleSelectedUIButtonBackSpace(Message : widget_message) : void = # 1文字削除ボタンが押されたときの処理
        if (SelectedButton := text_button_base[Message.Source]):
            if(UIState:=MaybeMyUIPerPlayer[Message.Player]?):
                var CurrentInput: string = UIState(2)
                var UpdatedString : string = ""
                for(Index->S:CurrentInput):
                    if(Index = CurrentInput.Length-1):
                    else:
                        set UpdatedString += "{S}"
                        # 最後の1文字を削除する
                if(set MaybeMyUIPerPlayer[Message.Player] = option{(UIState(0),UIState(1),UpdatedString)}){}
                UpdateUI(Message)
    HandleSelectedUIButtonClear(Message : widget_message) : void = # 全消去ボタンが押されたときの処理
        if(UIState:=MaybeMyUIPerPlayer[Message.Player]?):
            var CurrentInput:string=UIState(2)
            set CurrentInput = "" # 入力を空にする
            if(set MaybeMyUIPerPlayer[Message.Player] = option{(UIState(0),UIState(1),CurrentInput)}){}
            UpdateUI(Message)

    HandleSelectedUIButtonEnter(Message : widget_message) : void = # 確定ボタンが押されたときの処理
        Player := Message.Player
        if:
            UIState:=MaybeMyUIPerPlayer[Player]?
            EnteredPin:=UIState(2)
        then:
            var IsMatched : logic = false
            for(PasscodeEntry:Passcodes,not IsMatched?):
                ExpectedCode:="{PasscodeEntry.PIN}"
                if(ExpectedCode=EnteredPin):
                    set IsMatched = true # 成功
                    if(InnerTrigger:=PasscodeEntry.Trigger?): # トリガーデバイスが設定されている場合は起動する
                        InnerTrigger.Trigger(Player)
        RemovePinPad(Message.Player)
    RemovePinPad(Player:player):void=# UI を画面から削除する
        if(UIState:=MaybeMyUIPerPlayer[Player]?):
            if:
                PlayerUI:=GetPlayerUI[player[Player]]
            then:
                PlayerUI.RemoveWidget(UIState(0))
                if(set MaybeMyUIPerPlayer[Player] = false){}
    UpdateUI(Message:widget_message):void=# テキストの表示を更新する
        if(UIState:=MaybeMyUIPerPlayer[Message.Player]?):
            var CurrentInput:string=UIState(2)
            TB : button_regular = UIState(1)
            TB.SetText(TextForMyUI("{CurrentInput}"))