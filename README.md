
Contains a demo set of scripts for HPC training.

>Contributions to this demo are welcome, preferably by extending the code while maintaining generalizability.

## Content

1. Tutorial
	1. Getting started
		1. Accessing SSH
		2. SSH log-in
	2. Navigating the command line
		1. Bash basics
		2. git
	3. Running jobs
		1. Bash scripting
		2. Setting up a Python virtual environment
		3. Submitting jobs
	4. Monitoring and managing jobs


*********
# Tutorial

## 0. Getting Started

Before getting started, you need to request access to Hopper by filling out the form [here]([https://www.cac.cornell.edu/services/external/RequestCACid.aspx?ProjectID=vs498_0001](https://www.cac.cornell.edu/services/external/RequestCACid.aspx?ProjectID=vs498_0001)).

Once submitted, Vivek will need to approve access. After access is granted, you should receive and email from cac-help@cornell.edu with instructions on setting up your account. Be sure to remember your account password.

### 0.1 Accessing Secure SHell

Secure SHell, or SSH, is an *encrypted connection protocol* used to connect your local machine to a remote machine.  

We will use SSH to access Hopper. There are multiple options for accessing Hopper via SSH. 


Common options are: 
- VS Code Remote-SSH (my personal recommendation)
- [MobaXTerm](https://mobaxterm.mobatek.net/)
- [Mac Terminal](https://support.apple.com/guide/terminal/open-or-quit-terminal-apd5265185d-f365-44cb-8b09-71a064a42125/mac). The only downside of the Mac Terminal is that it does not provide an interactive GUI (visual folder system), and you must rely entirely on the command line.

### 0.2 SSH log-in

However you access the SSH terminal, you should enter the following command to initialize the SSH:
```
ssh <your_username>@<cluster>.cac.cornell.edu
```
You will then be prompted to enter your password.

For example, my personal log-in is `ssh tja73@hopper.cac.cornell.edu`

Once done with your work you can end the SSH connection by entering `exit` in the command line.

## 1. Navigating the command line

To navigate Hopper you need some basic knowledge of the [Bourne Again SHell](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) (bash).

Hopper has a Linux OS, and can be controlled using [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) shell and command language. Bash is was the default shell for the Mac OS Terminal prior to macOS 10.40, but it has been changed to [zsh](https://en.wikipedia.org/wiki/Z_shell) after that.

To change the shell to bash, see this [user guide](https://support.apple.com/guide/terminal/change-the-default-shell-trml113/mac#:~:text=The%20default%20shell%20is%20zsh,windows%20and%20tabs%20open%20with.).

### 1.1 Bash basics

A few notes on jargon, to avoid confusion:

>***Linux*** is an operating system kernel, which controls fundamental computer operations internally.   There are many different *linux distributions* which are each built upon the basic *linux kernel* while providing different command-line functionality and languages.

>A ***unix shell*** is used to facilitate command-line interaction with a linux OS.

>***Bash*** is a type of unix shell, and is thus a programming language which is used to operate a linux OS from the command-line.  


#### 1.1.1 Basic bash commands
This list is far from complete, but covers the necessities when it comes to navigating your project via the command line.

- `pwd` : print working directory
- `cd <directory>` : change directory
- `ls` : List the contents of the directory
- `mkdir <new_folder_location>`: make a new folder in specified directory
- `cp <file_name>` : copy
- `rm <file_name.txt>` : remove
- `clear` : clear the terminal screen
- `sudo <more commands>` : Temporarily elevate current user acount to have root privledge
- `touch <file_name>` : Create an empty file
- `cat <file_name>` : Read content of one or more file
- `echo` : Prints the text that follows it to the terminal
- `#` : Used to add comments to the script, explaining what the code does.
- `module load` : Loads a specific software module that is needed to run the script.
- `julia` : Runs the Julia interpreter.
- `$1`, `$2`, etc. : Used to access the arguments passed to the script
-  `&&` : Runs the command that follows it only if the previous command succeeded.
- `;` : Runs the command that follows it regardless of whether the previous command succeeded or not
-  `>` : Redirects the output of the command that precedes it to a file.
-  `<` : Uses the contents of a file as input to the command that follows it.

### Git

SSH is the recommended way to authenticate with GitHub from the HPC. It requires a one-time setup but never requires entering a password or managing tokens.

**One-time setup:** add your HPC public key to GitHub under Settings → SSH and GPG keys → New SSH key:
```bash
cat ~/.ssh/cluster.pub
```

**Clone a repository:**
```bash
git clone git@github.com:<username>/<repo_name>.git
```

**Push/pull** work normally after that with no credentials required.


## 2. Running jobs

### 2.1 Bash scripting
Using bash straight from the command line is a necessary but not sufficient skill for good HPC usage. To do it right, you should use bash scripting, which consists of writing a series of bash commands within a bash script and running the script as a whole

For example, you might write a bash script to:
-   Load required software modules needed to run your code on the HPC
-   Execute a program or script, such as a parallel code written in Python, Julia or other programming language, using MPI or other parallel computing libraries
-   Process the output of your code, such as sorting and filtering results
-   Repeat the above steps multiple times, each time with different input parameters

Here is a generic bash script template:
```bash
#!/bin/bash
# Load the required software module for the specific language
module load <language>

# Set the input variable
input="<input>"

# Execute the code with the specified input, and redirect both output and errors to text files
<language> <code_file> $input > <output_file>.txt 2> <error_file>.txt

# Check if the code execution was successful, and if not, print an error message
if [ $? -ne 0 ]; then
  echo "Error: code execution failed"
fi
```

### 2.2 Setting up a Python virtual environment

Before running Python jobs that require third-party packages (like `mpi4py`), create a virtual environment in your project directory:
```bash
module load python/3.11.5
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```
You only need to do this once. The job scripts will activate the venv automatically at runtime.

### 2.3 Submitting jobs
Enter the command:
```
sbatch <bash_file_name>.sh
```
SLURM will print a job ID, e.g. `Submitted batch job 12345`. Save this — you'll use it to monitor or cancel the job.

#### 2.3.1 Executing julia
Here is an example bash script that can be used to execute Julia code:
```bash
#!/bin/bash
# Load the Julia module
module load julia

# Run the Julia code (not parallel)
julia code.jl $1 $2
```
In this script, the first line specifies that it is a bash script. The second line loads the Julia module, which is necessary to run Julia code on the HPC. The third line runs the Julia code using the `julia` command, with two arguments passed to the code.

To run the script, open a terminal, navigate to the directory where the script and the Julia code are located, and type:
```
sbatch script.sh arg1 arg2
```
Where `arg1` and `arg2` are the arguments passed to the Julia code.


## 3. Monitoring and managing jobs

After submitting a job with `sbatch`, use these commands to track it.

**Check job status:**
```bash
squeue -u $USER
```
The `ST` column shows the job state:
- `PD` — pending (waiting for resources)
- `R` — running
- `CG` — completing

**Cancel a job:**
```bash
scancel <jobid>
```

**View output after the job finishes:**
```bash
cat output/output_text.txt
cat output/error_text.txt
```
Output is only written to these files after the job completes (or is terminated). If the files are empty, the job may still be running.


*******
# Resources
(1) [Cornell CAC wiki page for hopper](https://www.cac.cornell.edu/wiki/index.php?title=Hopper_Cluster)
(2) [Cornell CAC wiki page for Slurm](https://www.cac.cornell.edu/wiki/index.php?title=Slurm)
(3) [Reed Group Lab Manual: Cluster Basics](https://reedgroup.github.io/Resources/ClusterBasics.html)
(4) [Dave's post on batch parallelization of code using mpi4py](https://waterprogramming.wordpress.com/2021/11/10/easy-batch-parallelization-of-code-in-any-language-using-mpi4py/)
(5) [*A list of bash FAQ*](https://mywiki.wooledge.org/BashFAQ)
(6) [A nice page of different example bash scripts with descriptions](https://tldp.org/LDP/abs/html/)
