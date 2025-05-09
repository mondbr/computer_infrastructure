<img src="https://beyondthestates.com/wp-content/uploads/2023/09/download.png" width=20% height=20%>

# Computer Infrastructure

************************
*My assessment repository* 
************************

This is the assessment repository for Computer Infrastructure module on Higher Diploma in Data Analytics course from [ATU](https://www.atu.ie/) in Winter 2024/25. 

**author: Monika Dabrowska**

## Overview

This repository includes a Jupyter Notebook (weather.ipynb), `data` directory and other files that documents the process of completing Tasks 1 - 9 and Project for the assessment. The tasks involved creating directory structures, generating timestamps, downloading weather data, and managing files using command-line tools in a GitHub Codespace environment. Below is a summary of the notebook's content and the commands used.


## Requirements 

- Access to GitHub Codespaces with Bash enabled.

- Basic understanding of Bash commands and file operations.

- Internet connection for downloading data using `wget`.

## GitHub Codespaces 

GitHub Codespaces is a cloud-based integrated development environment (IDE) that provides their users with a fully configured and customizable coding workspace, that is accessible from anywhere. It is tightly integrated with GitHub, allowing developers to easily spin up development environments for their repositories with minimal setup. The codespace can be created directly from user GitHub repository and it has a monthly number of hours of free use. 

GitHub Account: You need a GitHub account. If you don't have one, create it at [GitHub](https://github.com/).

### How to open GitHub Codespaces:

- You can open any GitHub repository in Codespaces. You can create a new repository on GitHub or see existing project like mine below.
- Copy the repository from [here](https://github.com/mondbr/computer_infrastructure) and paste in your browser
- Click on the green `<>Code` button
- Select `Create codespace on main` 

<img src="https://github.com/mondbr/computer_infrastructure/blob/main/codespaces.png" width=20% height=20%> 

- This will open a new cloud-based development environment in your browser. You can interact with it just like a local development environment:

    -   Write Code: Use the built-in editor (VS Code) to write, edit, and       manage your code.
    -   Run Code: Open a terminal in your Codespace and run your application just as you would locally.

    -   Version Control: You can commit changes and push them back to GitHub directly from the Codespace. Git and GitHub integration is built-in, allowing easy management of your source code.

Before exiting your Codespace, ensure all your changes are committed and pushed to the repository. 

You can stop a Codespace by going to your GitHub account, navigating to *Settings > Codespaces*, and selecting the *Stop* option for your active Codespace. This will save your work and stop the environment, and you can resume later.

You can restart your Codespace at any time from the GitHub repository page. Go to the Code button again and select *Reopen in Codespaces*.

## Task Summary 
### Task 1: Create Directory Structure
- **Goal**: Create a directory named `data` with subdirectories `timestamps` and `weather`.
- **Commands used**:

```bash
mkdir -p data/weather
cd data/
mkdir timestamps
```

The `mkdir -p` command ensures parent directories are created if they do not exist.

### Task 2: Timestamps
- **Goal**: Save the current date and time to `now.txt`, appending 10 entries.
- **Commands used**:

```bash
date +'%Y/%m/%d/ %H:%M:%S' >> now.txt
more now.txt
```
The `date` command outputs the current timestamp, while `>>` appends the output to the file. The `more` command displays the file content

### Task 3: Formatting Timestamps
- **Goal**: Append formatted timestamps `(YYYYmmdd_HHMMSS)` to `formatted.txt`.
- **Commands used**: 

```bash 
date -d "2026-11-14 13:00:03" +'%Y%m%d_%H%M%S' >> formatted.txt
cat formatted.txt
```
The `cat` command is used to verify the content.

### Task 4: Create Timestamped Files
- **Goal**: Create empty files with timestamped names in the format `YYYYmmdd_HHMMSS.txt.`
- **Commands used**:

```bash
touch `date +'%Y%m%d_%H%M%S'`.txt
ls
```
Embedded backticks execute the `date` command inline to name the files.

### Task 5: Download Today's Weather Data
- **Goal**: Download the latest weather data from Met Éireann and save it as `weather.json.`
- **Commands used**:

```bash
wget -O weather.json https://prodapi.metweb.ie/observations/athenry/today
ls
```
The `-O` option specifies the output filename.

### Task 6: Timestamp the Data
- **Goal**: Save the downloaded weather data with a timestamped filename.
- **Commands used**:

```bash
wget -O `date +'%Y%m%d_%H%M%S'`.json https://prodapi.metweb.ie/observations/athenry/today
ls
```
This ensures each file is uniquely named with a timestamp.


### Task 7: Write the Script
- **Goal**: Automate the tasks with a Bash script.
- **Commands used**: Full details are available in the [weather.ipynb](https://github.com/mondbr/computer_infrastructure/blob/main/weather.ipynb) notebook. 


### Task 8: Notebook
- **Goal**: Write a brief report of how tasks 1-7 were completed.
- **Commands used**: Full details are available in the [weather.ipynb](https://github.com/mondbr/computer_infrastructure/blob/main/weather.ipynb) notebook. 


### Task 9: pandas
- **Goal**: Using `pandas` function to load the data, summarize and examine it. 
- **Commands used**: Full details are available in the [weather.ipynb](https://github.com/mondbr/computer_infrastructure/blob/main/weather.ipynb) notebook.


### Project
***
- **Goal**: Automate the `weather.sh` script using GitHub Actions:
- **Commands used**: Full details are available in [weather-data.yml](https://github.com/mondbr/computer_infrastructure/blob/main/.github/workflows/weather-data.yml). 

- **Summary of actions**:

1. Creating GitHub Actions Workflow:
    - In my repository, I created a `.github/workflows/` folder
    - Inside this folder, I created a file named `weather-data.yml` to define the GitHub Actions workflow.
2. Setting Daily Run at 10am:
    - I used the `schedule` event with `cron` to run the script once a day at 10am.
    - I added the `workflow_dispatch` event to allow manual testing of the workflow.
3. Setting up the permissions:
    - The workflow grants write permissions to the repository contents `(contents: write)` so that it can push changes back to the repository if any modifications occur during the script execution.
4. Using Ubuntu Virtual Machine:
    - In the workflow file, I specified an Ubuntu virtual machine `(ubuntu-latest)` to run the action `run-weather-script`
5. Setting up the steps:
    - **Step 1.** I checked `wget` and `curl` versions (which are usually pre-installed on Ubuntu systems), to confirm that they are available.
    - **Step 2.** I used the `actions/checkout@v4 action` to check out the repository's code, making the repository's files accessible to the workflow.
    - **Step 3.** Executing the `weather.sh` script: I added a step to run `weather.sh` script within the workflow ensuring it is executable by `chmod +x weather.sh`. 
    The script is then executed `(./weather.sh)` to download and save data.
    - **Step 4.** Commit and Push Changes: I used `env` and `GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}` to authenticate and interact with the repository. The token is stored as a secret in the GitHub repository settings to keep it secure.
    `git config`, `git add .`, `git commit - m` and `git push` automates the process of committing and pushing changes to your repository if any new changes have been made (e.g., updates to the weather data).



## Key Learnings and Notes
1. Command-line Utilities:
-  `touch`, `mkdir`, `date`, `wget`, `cat`, and more were crucial to task completion.
2. Timestamping Techniques:
- `date` formatting options `(%Y, %m, %d, %H, %M, %S)` were used to standardize file naming.

## How to Run the Notebook
1. Clone the repository and open it in a GitHub Codespace.

2. Ensure all required files and directories exist.

3. Run the notebook sequentially to replicate the tasks.


## About me: 

My name is Monika Dabrowska and I am an [ATU](https://www.atu.ie/) student of third semester of the Computer Infrastructure module on the Higher Diploma in Data Analytics course during Winter 2024/25.


If you wish to contact me directly, please email me @ mondbr133@gmail.com

## References

1. https://www.serveracademy.com/blog/how-to-use-the-touch-command-in-linux

2. https://github.com/trinib/Linux-Bash-Commands

3. https://www.charmm-gui.org/?doc=lecture&module=unix&lesson=2

4. https://www.geeksforgeeks.org/more-command-in-linux-with-examples

5. https://data.gov.ie/dataset/todays-weather-athenry

6. [chat.openai.com](https://chatgpt.com/?ref=dotcom)























