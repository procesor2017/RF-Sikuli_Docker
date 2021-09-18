*** Settings ***
Documentation     Sikuli Library Demo
Test Setup        Add Needed Image Path
Test Teardown     Stop Remote Server
Library           SikuliLibrary

*** Variables ***
${IMAGE_DIR}      ${CURDIR}\\image

*** Test Cases ***
Windows Notpad Hellow World
    Find notepad
    # Open Windows Start Menu
    # Open Notepad
    # Input In Notepad
    # Quit Without Save

*** Keywords ***
Find notepad
    Click           search_input.png

Add Needed Image Path
    Add Image Path    ${IMAGE_DIR}

Open Windows Start Menu
    Click    windows_start_menu.png

Open Notepad
    Click          search_input.png
    Input Text    search_input.png    notepad
    Click    notepad.png
    Double Click    notepad_title.png

Input In Notepad
    Input Text    notepad_workspace.png    Hello World
    Text Should Exist    Hello World

Quit Without Save
    Click    close.png
    Click    dont_save.png