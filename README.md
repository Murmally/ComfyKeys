# ComfyKeys

## Introduction
This program is meant to help you keep your StarCraft 2 hotkey profiles updated over all your SC2 accounts.
It does so by creating a separate **hotkey branch** for each race and one branch as the *Main* hotkey profile. It also propagates the selected profile into *Latest*.



## Requirements
The program requires language Ruby installed. If you are not sure, whether you have Ruby installed, open your command prompt and type `ruby -v`. In case CMD doesn't recognize the command, you need to download and install Ruby from [this](https://www.ruby-lang.org/en/downloads/) site, preferably version 2.5.5 or newer.



## How to use, step by step
1. Download ComfyKeys.rb file to your SC2 profile hotkey folder. The default path of this folder is `*\Documents\StarCraft II\Accounts`.
2. Open your command prompt in the **same folder** where you downloaded your `ComfyKeys.rb`, then type `ruby ComfyKeys.rb` and hit Enter
3. The console should now show the most recently edited hotkey profiles for each one of your accounts. You need to the pick one you want to synchronize by typing the appropriate number.
4. Next you need to decide on what branch you want to put his profile. Viable answers are `z`, `Z`, `p`, `P`, `t` and `T`. The letters traditionally stand for their races, letter `M` is for *Main*
5. Now you can add a version identification, eg. `1.6.0`, `my_keys`. If you don't want any version suffix, simply type nothing.
6. Press Enter

