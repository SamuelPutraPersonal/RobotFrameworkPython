*** Settings ***
Documentation       A complete login test script for nopCommerce with bot-detection bypass.

Library             SeleniumLibrary


*** Variables ***
${browser}      chrome
${url}          https://demo.nopcommerce.com/
${email}        test@example.com
${password}     Test@123


*** Test Cases ***
Login Test
    [Documentation]    Starts the browser with stealth options and performs login.
    Setup Stealth Browser
    Set Selenium Speed    0.5 seconds
    Login To Application
    [Teardown]    Close Browser


*** Keywords ***
Setup Stealth Browser
    # Create Chrome Options to bypass bot detection
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    # These arguments hide the "automated" nature of the browser
    Call Method    ${options}    add_argument    --disable-blink-features\=AutomationControlled
    Call Method    ${options}    add_experimental_option    excludeSwitches    ${{['enable-automation']}}
    Call Method    ${options}    add_argument    --start-maximized

    Open Browser    ${url}    ${browser}    options=${options}
    # Optional: Wait a moment for the site to settle
    Sleep    2s

Login To Application
    # 1. Click the Login link at the top
    Wait Until Element Is Visible    xpath://a[@class='ico-login']    timeout=10s
    Click Link    xpath://a[@class='ico-login']

    # 2. Enter Credentials
    Wait Until Element Is Visible    id:Email    timeout=5s
    Input Text    id:Email    ${email}
    Input Password    id:Password    ${password}

    # 3. Click the Login button (Fixed the 'loqin' typo here)
    Click Element    xpath://button[contains(@class,'login-button')]
