port module Main exposing (main)

import Browser
import Css
import Css.Global as Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Html
import Svg.Styled as SS
import Svg.Styled.Attributes as SSA
import Tailwind.Utilities as Tw



-- MODEL


type alias Flags =
    { appVersion : String }


type AppVersion
    = CurrentVersion String
    | NewVersion String


type alias Model =
    { appVersion : AppVersion
    }


init : Flags -> ( Model, Cmd Msg )
init { appVersion } =
    ( { appVersion = CurrentVersion appVersion }, Cmd.none )



-- UPDATE


type Msg
    = OnNewVersion String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ appVersion } as model) =
    case msg of
        OnNewVersion version ->
            let
                newAppVersion =
                    if isNewVersion version appVersion then
                        NewVersion version

                    else
                        CurrentVersion version
            in
            ( { model | appVersion = newAppVersion }, Cmd.none )


isNewVersion : String -> AppVersion -> Bool
isNewVersion version appVersion =
    case appVersion of
        CurrentVersion v ->
            v == version

        NewVersion v ->
            v == version



-- PORTS


port newVersion : (String -> msg) -> Sub msg



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    newVersion OnNewVersion



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "VersionObserver"
    , body =
        model
            |> mainView
            |> List.map Html.toUnstyled
    }


mainView : Model -> List (Html Msg)
mainView { appVersion } =
    [ Css.global Tw.globalStyles
    , popupView appVersion
    , Html.main_
        [ Html.attribute "role" "main"
        , Html.css
            [ Tw.w_full
            , Tw.flex
            ]
        ]
        [ Html.aside
            [ Html.css
                [ Tw.bg_gray_50
                , Tw.w_56
                , Tw.h_screen
                , Tw.p_6
                , Tw.flex
                , Tw.flex_col
                ]
            ]
            [ Html.div
                [ Html.css
                    [ Tw.border_b
                    , Tw.border_gray_200
                    , Tw.pb_4
                    , Tw.mb_10
                    ]
                ]
                [ Html.div
                    [ Html.css
                        [ Tw.rounded_full
                        , Tw.h_16
                        , Tw.w_16
                        , Tw.flex
                        , Tw.items_center
                        , Tw.justify_center
                        , Tw.bg_purple_500
                        , Tw.mb_4
                        ]
                    ]
                    []
                , Html.div
                    [ Html.css
                        [ Tw.rounded_full
                        , Tw.h_2
                        , Tw.w_8over12
                        , Tw.bg_gray_400
                        , Tw.mb_4
                        ]
                    ]
                    []
                , Html.div
                    [ Html.css
                        [ Tw.rounded_full
                        , Tw.h_1
                        , Tw.w_10over12
                        , Tw.bg_gray_300
                        , Tw.mb_4
                        ]
                    ]
                    []
                ]
            , Html.div
                [ Html.css
                    [ Tw.flex
                    , Tw.flex_1
                    , Tw.flex_col
                    ]
                ]
                [ Html.div
                    [ Html.css
                        [ Tw.rounded_full
                        , Tw.h_2
                        , Tw.cursor_pointer
                        , Tw.bg_gray_300
                        , Tw.w_6over12
                        , Tw.mb_8
                        , Css.hover
                            [ Tw.bg_gray_400
                            ]
                        ]
                    ]
                    []
                , Html.div
                    [ Html.css
                        [ Tw.rounded_full
                        , Tw.h_2
                        , Tw.cursor_pointer
                        , Tw.bg_gray_300
                        , Tw.w_8over12
                        , Tw.mb_8
                        , Css.hover
                            [ Tw.bg_gray_400
                            ]
                        ]
                    ]
                    []
                , Html.div
                    [ Html.css
                        [ Tw.rounded_full
                        , Tw.h_2
                        , Tw.cursor_pointer
                        , Tw.bg_gray_400
                        , Tw.w_10over12
                        , Tw.mb_8
                        , Css.hover
                            [ Tw.bg_gray_400
                            ]
                        ]
                    ]
                    []
                , Html.div
                    [ Html.css
                        [ Tw.rounded_full
                        , Tw.h_2
                        , Tw.cursor_pointer
                        , Tw.bg_gray_300
                        , Tw.w_4over12
                        , Tw.mb_8
                        , Css.hover
                            [ Tw.bg_gray_400
                            ]
                        ]
                    ]
                    []
                , Html.div
                    [ Html.css
                        [ Tw.rounded_full
                        , Tw.h_2
                        , Tw.cursor_pointer
                        , Tw.bg_gray_300
                        , Tw.w_6over12
                        , Tw.mb_8
                        , Css.hover
                            [ Tw.bg_gray_400
                            ]
                        ]
                    ]
                    []
                , Html.div
                    [ Html.css
                        [ Tw.rounded_full
                        , Tw.h_1
                        , Tw.w_8over12
                        , Tw.bg_gray_300
                        , Tw.mb_4
                        , Tw.mt_auto
                        ]
                    ]
                    []
                ]
            ]
        , Html.section
            [ Html.css
                [ Tw.flex_1
                ]
            ]
            [ Html.div
                [ Html.attribute "role" "alert"
                , Html.attribute "phx-click" "lv:clear-flash"
                , Html.attribute "phx-value-key" "info"
                ]
                []
            , Html.div
                [ Html.attribute "role" "alert"
                , Html.attribute "phx-click" "lv:clear-flash"
                , Html.attribute "phx-value-key" "error"
                ]
                []
            , Html.section
                [ Html.css
                    [ Tw.px_6
                    ]
                ]
                [ Html.header
                    [ Html.css
                        [ Tw.py_8
                        , Tw.border_b
                        , Tw.border_gray_100
                        ]
                    ]
                    [ Html.div
                        [ Html.css
                            [ Tw.rounded_full
                            , Tw.h_2
                            , Tw.bg_gray_400
                            , Tw.w_3over12
                            , Css.hover
                                [ Tw.bg_gray_400
                                ]
                            ]
                        ]
                        []
                    ]
                , Html.div
                    [ Html.css
                        [ Tw.my_6
                        , Tw.flex
                        , Tw.items_center
                        , Tw.gap_x_4
                        ]
                    ]
                    [ Html.div
                        [ Html.css
                            [ Tw.bg_gray_100
                            , Tw.h_8
                            , Tw.w_44
                            , Tw.rounded_md
                            ]
                        ]
                        []
                    , Html.div
                        [ Html.css
                            [ Tw.bg_gray_100
                            , Tw.h_8
                            , Tw.w_44
                            , Tw.rounded_md
                            ]
                        ]
                        []
                    , Html.div
                        [ Html.css
                            [ Tw.bg_gray_100
                            , Tw.h_8
                            , Tw.w_44
                            , Tw.rounded_md
                            ]
                        ]
                        []
                    ]
                , Html.div []
                    [ Html.div
                        [ Html.css
                            [ Tw.grid
                            , Tw.grid_cols_6
                            , Tw.gap_x_4
                            , Tw.border_b
                            , Tw.border_t
                            , Tw.border_gray_100
                            , Tw.py_4
                            ]
                        ]
                        [ Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_400
                                , Tw.w_2over12
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_400
                                , Tw.w_3over12
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_400
                                , Tw.w_5over12
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_400
                                , Tw.w_3over12
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_400
                                , Tw.w_4over12
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_400
                                , Tw.w_1over12
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div []
                            []
                        ]
                    , Html.div
                        [ Html.css
                            [ Tw.grid
                            , Tw.grid_cols_6
                            , Tw.gap_x_4
                            , Tw.py_4
                            ]
                        ]
                        [ Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_1over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_1over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_1over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_1over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_4over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_4over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_4over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_1over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_1over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_1over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_4over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_4over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_4over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_1over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_1over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_2over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_1over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_4over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_4over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_1over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_3over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        , Html.div
                            [ Html.css
                                [ Tw.rounded_full
                                , Tw.h_2
                                , Tw.bg_gray_300
                                , Tw.w_5over12
                                , Tw.my_4
                                , Css.hover
                                    [ Tw.bg_gray_400
                                    ]
                                ]
                            ]
                            []
                        ]
                    ]
                ]
            ]
        ]
    ]


popupView : AppVersion -> Html msg
popupView appVersion =
    case appVersion of
        CurrentVersion _ ->
            Html.text ""

        NewVersion _ ->
            Html.div
                [ Html.css
                    [ Tw.bg_white
                    , Tw.p_5
                    , Tw.rounded
                    , Tw.shadow_md
                    , Tw.absolute
                    , Tw.top_0
                    , Tw.right_0
                    , Tw.w_80
                    , Tw.mt_6
                    , Tw.mr_6
                    , Tw.border_gray_100
                    , Tw.border
                    , Tw.text_sm
                    , Tw.leading_5
                    , Tw.flex
                    , Tw.gap_x_4
                    ]
                , Html.class "bounce-in-top"
                ]
                [ Html.div
                    [ Html.css
                        [ Tw.pt_1
                        , Tw.text_yellow_400
                        ]
                    ]
                    [ SS.svg
                        [ Html.attribute "aria-hidden" "true"
                        , Html.attribute "focusable" "false"
                        , Html.attribute "role" "img"
                        , Html.height 16
                        , Html.width 16
                        , SSA.viewBox "0 0 576 512"
                        ]
                        [ SS.path
                            [ SSA.fill "currentColor"
                            , SSA.d "M569.517 440.013C587.975 472.007 564.806 512 527.94 512H48.054c-36.937 0-59.999-40.055-41.577-71.987L246.423 23.985c18.467-32.009 64.72-31.951 83.154 0l239.94 416.028zM288 354c-25.405 0-46 20.595-46 46s20.595 46 46 46 46-20.595 46-46-20.595-46-46-46zm-43.673-165.346l7.418 136c.347 6.364 5.609 11.346 11.982 11.346h48.546c6.373 0 11.635-4.982 11.982-11.346l7.418-136c.375-6.874-5.098-12.654-11.982-12.654h-63.383c-6.884 0-12.356 5.78-11.981 12.654z"
                            , SSA.css []
                            ]
                            []
                        ]
                    ]
                , Html.div []
                    [ Html.h4
                        [ Html.css
                            [ Tw.font_bold
                            , Tw.mb_2
                            ]
                        ]
                        [ Html.text "New application version available" ]
                    , Html.p
                        [ Html.css
                            [ Tw.text_gray_500
                            ]
                        ]
                        [ Html.text "Please refresh this page to use the new version." ]
                    ]
                ]


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
