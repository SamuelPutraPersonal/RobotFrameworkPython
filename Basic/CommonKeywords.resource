*** Settings ***
Library     SeleniumLibrary


*** Variables ***
# These are only used when run_in_docker is True
${DOCKER_CHROME_BINARY}         /usr/bin/chromium
${DOCKER_CHROME_DRIVER_PATH}    /usr/bin/chromedriver
# --- CENTRAL CONTROL ---
# Set to 'False' for local Mac (Headed)
# Set to 'True' for Docker/GitHub (Headless)
${RUN_IN_DOCKER_MODE}           False


*** Keywords ***
Open Browser Custom
    [Arguments]    ${target_url}    ${run_in_docker}=${RUN_IN_DOCKER_MODE}

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    IF    '${run_in_docker}' == 'True'
        # --- DOCKER / PIPELINE SETTINGS ---
        Call Method    ${options}    add_argument    --headless=new

        # ESSENTIAL FOR GITHUB ACTIONS:
        Call Method    ${options}    add_argument    --no-sandbox
        Call Method    ${options}    add_argument    --disable-dev-shm-usage
        Call Method    ${options}    add_argument    --disable-gpu

        # --- STEALTH ADDITIONS ---
        Call Method    ${options}    add_argument    --disable-blink-features\=AutomationControlled
        Call Method    ${options}    add_experimental_option    excludeSwitches    ${{['enable-automation']}}
        Call Method
        ...    ${options}
        ...    add_argument
        ...    user-agent\=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36

        ${options.binary_location}=    Set Variable    ${DOCKER_CHROME_BINARY}

        ${service}=    Evaluate
        ...    sys.modules['selenium.webdriver.chrome.service'].Service(executable_path='${DOCKER_CHROME_DRIVER_PATH}')
        ...    sys, selenium.webdriver.chrome.service
        Create Webdriver    Chrome    options=${options}    service=${service}
    ELSE
        # On Mac, we don't set binary_location or service.
        # Selenium Manager will find your installed Chrome automatically.
        # --- LOCAL MAC STEALTH SETTINGS ---
        Call Method    ${options}    add_argument    --disable-blink-features\=AutomationControlled
        Call Method    ${options}    add_experimental_option    excludeSwitches    ${{['enable-automation']}}
        Call Method    ${options}    add_experimental_option    useAutomationExtension    ${False}

        Open Browser    ${target_url}    chrome    options=${options}

        # This Javascript execution hides the 'webdriver' flag from Cloudflare
        Execute Javascript    Object.defineProperty(navigator, 'webdriver', {get: () => undefined})

        Maximize Browser Window
    END

    Go To    ${target_url}
