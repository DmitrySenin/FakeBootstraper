# What problem does it help to solve?
This is a PowerShell script to comprehensively set up an environment to use [Fake](https://fake.build/index.html)

# How to use it
1. Download the script into the folder wher you want to implement your build system
2. Open Windows PowerShell
3. Put down `.\build.ps1 -CreateDraftFsx`

# The result
The current folder has all the infrstructure to use Fake right away:
1. The latest **stable** version of Fake is downloaded
2. _Fake.exe_ and _FakeLib.dll_ are in ".\packages\FAKE\tools\"
3. A draft of a build script is created and named as `build.fsx`

# Using Fake
Fake can also be used via this script. All that need to be done is to invoke the script with necessary Fake's parameters. For instance: `.\build.ps1 Clean` will invoke the Clean task of `build.fsx`.
You can can also optionally provide the 'Script' parameter to specify the name of the build script. For instance, the alternative to `.\build.ps1 <Task>` but with a specified script is the following command: `.\build.ps1 -Script "my_test.fsx <Task>"`

# Undercover
From all [the ways](https://fake.build/fake-gettingstarted.html#Create-and-Edit-scripts-with-Intellisense) offered on the official web-site, the [paket](https://fsprojects.github.io/Paket/) approach appealed to me most of all because:
1. I don't want to have all memebers of my team install chockolotey and Fake globally
2. I also don't want to have a .Net Core locally or make anybody install it

So the script downloads Paket to the current folder and set up all necessary infrastructure to use it:
1. `paket.exe` can be found under the '.paket' folder
2. `paket.dependencies` and `paket.lock` are created in the current folder

Considering this, you will have to add `.paket` to your `.gitignore` and add `paket.dependencies` and `paket.lock` to your repository

Also if you specify the `-CreatedDraftFsx` parameter then the script also creates a blueprint of a build script with examples of tasks. By providing the 'Script' parameter, you can controll the name of that script.
