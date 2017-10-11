# Seqs-Extractor user manual

								
**Support, feedback or questions to patrick@ufpa.br**

Version 1.0 (Mar 15, 2017) Copyright (c) 2017 By Patrick Douglas email: patrick@ufpa.br 
Seqs-Extractor home page: https://seqs-extractor.sourceforge.io

# What Is Seqs-Extractor ?
A simple tool to help extraction of:

- BLASTed sequences using the tabular BLAST file and query sequences, producing a .FASTA file containing only sequences that matched with 
a specific percentage defined by the user. This software also turns BLAST command line more friendly.

- Sequences containing microssatellites of a MISA file, producing a .FASTA file with only the sequences that contain the microssatellites. 
Seqs-Extractor allows you to run a MISA search and after extract the sequences, or just to extract the sequences from a MISA file already generated. 

- Sequences from any .FASTA file through a text file containing the IDs of the target sequences.

It works with shell bash. Seqs-Extractor is developed for Linux, it should also work with any UNIX operating system with Debian based and was tested under 
Linux Mint 17.3 xfce and Ubuntu 16.4 LTs.

# Minimum System Requirements
	- Linux Debian based operating system.
	- Internet access is required during installation process

# Documentations in the Distribution
	README			Program usage 
	INSTALL			Installation procedure
	HOW TO USE		General instructions about usage
	THIRD-PARTY SOFTWARE	Information about Third-party software used by Seq-Extractor pipeline
	REFERENCES		Papers for check 

# How to install, uninstall or reinstall:
# Linux Mint/Ubuntu
Open a terminal window and type the following commands:

	$ sudo -i

	$ cd (to folder where you unpack the software files, EXAMPLE "cd /home/jhon/Downloads/seqs-extractor")

	$ chmod +x installer.sh

	$ ./installer.sh
# Mac OSX
Open a terminal window and type the following commands:

	$ cd (to folder where you unpack the software files, EXAMPLE "cd /home/jhon/Downloads/seqs-extractor")

	$ chmod +x installer.sh

	$ ./installer.sh
	
You will be asked to choose an option as bellow:
------------------------------------------------

	1 To install Seqs-Extractor and all required tools
	2 To uninstall Seqs-Extractor and all required tools
	3 To reinstall Seqs-Extractor and all required tools

By using option 1 or 3, you agree with the installation of BLAST+ standalone tools (Altschul, et al 1990), SAMTOOLS (Li, et al., 2009) 
and MISA (Thiel, 2003), which are required to some analyses.
**NOTE: Option 3 only is available for Linux Mint/Ubuntu**



How to run
==========
Open a terminal window and type:
--------------------------------

    seqs-extractor

### Or just open Seqs-Extractor from Linux main menu   
**NOTE: There is no desktop or launcher icon for MAC OSX**

### The work folder
To start you will need to choose a folder to work. Is usually the directory where your files are, the results will be generated in this directory.
**Please use the format below:**

    /home/user/example/

If you leave this in blank the software will use your **$HOME** folder as default

To use a file that is not in the working folder, enter the path with the file name, example:

	/home/user/example/example.fasta

# How to use

## **1.**	Just to perform a BLAST search:
------------------------------------------
#### This option will perform a BLAST search using NCBI-BLAST+.

**1.1** 	You will be asked to choose between BLASTn or BLASTx (Others BLAST+ tools are not available at this moment).

**1.2** 	Type the name of .FASTA file you want to use in the BLAST search (example: ***M.musculus_NCBI_entire_genome.fasta***). Here is your query sequences.

**1.3** 	You will decide to format a BLAST database or to use an already formatted (see NCBI BLAST+ documentation to more details). 
	**1.3.1**	[FORMAT A BLAST DATABASE] Enter the name of .FASTA file that you want to format (example: ***Mus_musculus_uniprot_swisprot.fasta***):
		**1.3.1.1**	The software will run the following command to format BLAST database:
**NOTE: This command will be performed automatically and depends of your choice in item 1.1**
##### IF YOU DECIDE TO USE BLASTx
    $ makeblastdb -in name_of_your_database_to_BLAST.fasta -dbtype prot

#### IF YOU DECIDE TO USE BLASTn
	$ makeblastdb -in name_of_your_database_to_BLAST.fasta -dbtype nucl

**1.3.2	[USE A DATABASE ALREADY FORMATTED]** Enter the name of .FASTA file you want to use as BLAST preformated database. This command is useful if you already performed **makeblastdb** command and do not want run it again.

**1.4**	Enter the expected value (E-value) that you want to use in the BLAST search.
Example:

    1e-20


**1.5**	Enter how many CPU-cores you want to use in the BLAST search.
NOTE: In the linux Mint/Ubuntu environment the comand **nproc** shows the total number of threads avaliable
Example:

    12

**1.6**	Enter the format of BLAST results output file you want to be generated. Here you can type help to get all available formats, or you can read the BLAST+ documentation to get more help.
Example: type **6** to generate a file in tabular format
        
    6
**1.7**	In this phase you can insert additional BLAST parameters separated by spaces and starting with dashes, or you can just hit ENTER key to skip 
Example: 

    -max_target_seqs 1 -num_descriptions 10

**1.8**	Some BLAST parameters are **mandatory** to use these tools, they are:

	-query			Your .FASTA file

	-db 			The database to BLAST

	-e-value 		The expected value of BLAST search

	-num_threads 	The number of CPU cores to parallel processing of BLAST search

	-outfmt			The output format of BLAST results
**NOTE However, you can add other BLAST parameters (see topic **1.7** of this manual)**
After this phase you are ready, just wait and the BLAST results will be generated in the same folder that you are working.
This can take a long time and depends of the size of your datasets (query.fasta and database).

### The file will be named as follows:
	BLAST-evalue.outfmt

## **2.**	BLAST and extract the sequences
------------------------------------------
This option will perform a BLAST search using NCBI-BLAST+ and after it will extract only the sequences that match with the subject database, in a specific percentage defined by the user.
**EXAMPLE: After a BLAST run you can use the tabular BLAST format to extract from your query dataset only the sequences that match in a specific percentage of hits, like 100%.**

**2.1**	You will be asked to choose between BLASTn or BLASTx (**Others BLAST+ tools are not available at this moment**).

**2.2**	Type the name of .FASTA file you want to use in the BLAST search
Example: ***M.musculus_NCBI_entire_genome.fasta***). Here is your query sequences.

**2.3**	You will decide to format a BLAST database or to use an already formatted (see NCBI BLAST+ documentation to more details). 
	
**2.3.1	[FORMAT A BLAST DATABASE]** Enter the name of .FASTA file that you want to format (example: ***Mus_musculus_uniprot_swisprot.fasta***):

**2.3.1.1**	The software will run the following command to format BLAST database:
**NOTE: This command will be performed automatically and depends of your choice in item 2.1**
##### IF YOU DECIDE TO USE BLASTx
    $ makeblastdb -in name_of_your_database_to_BLAST.fasta -dbtype prot

#### IF YOU DECIDE TO USE BLASTn
	$ makeblastdb -in name_of_your_database_to_BLAST.fasta -dbtype nucl

**2.3.2	[USE A DATABASE ALREADY FORMATTED]** Enter the name of .FASTA file you want to use as BLAST preformated database. This command is useful if you already performed **makeblastdb** command and do not want run it again.

**2.4**	In this phase you can insert additional BLAST parameters separated by spaces and starting with dashes, or you can just hit ENTER key to skip 
Example: 

    -max_target_seqs 1 -num_descriptions 10

**2.5**	Some BLAST parameters are **mandatory** to use these tools, they are:

	-query			Your .FASTA file

	-db 			The database to BLAST

	-e-value 		The expected value of BLAST search

	-num_threads 	The number of CPU cores to parallel processing of BLAST search

	-outfmt			The output format of BLAST results
**NOTE: However, you can add other BLAST parameters (see topic **2.3** of this manual)**

**2.6**	Now you can choose a specific percentage to extract your sequences, you can type **help** and see all available options and you will see the screen bellow:
Bellow the **Help** page

	type  10  to get only the sequences that match with 10%	
	type  20  to get only the sequences that match with 20%	
	type  30  to get only the sequences that match with 30%		
	type  40  to get only the sequences that match with 40%		
	type  50  to get only the sequences that match with 50%		
	type  60  to get only the sequences that match with 60%		
	type  70  to get only the sequences that match with 70%		
	type  80  to get only the sequences that match with 80%		
	type  90  to get only the sequences that match with 90%		
	type  100  to get only the sequences that match with 100%
	type  10-100  to get only the sequences that match with 10% to 100% of hits	
	type  20-100  to get only the sequences that match with 20% to 100% of hits	
	type  30-100  to get only the sequences that match with 30% to 100% of hits	
	type  40-100  to get only the sequences that match with 40% to 100% of hits	
	type  50-100  to get only the sequences that match with 50% to 100% of hits	
	type  60-100  to get only the sequences that match with 60% to 100% of hits	
	type  70-100  to get only the sequences that match with 70% to 100% of hits	
	type  80-100  to get only the sequences that match with 80% to 100% of hits	
	type  90-100  to get only the sequences that match with 90% to 100% of hits	

	Or type all to no filter and get all sequences the match in the blast search.

**2.7**	The final screen will indicate the name of files, and the created database files will be stored in the same directory you are working and you can delete it if you prefer to.

## **3.** To perform extraction without run a BLAST search 
--------------------------------------------------
You can also only extract, if you already performed a BLAST search, however you will need a **tabular BLAST results file** (choose the option 6 for generate an output file in this format) to use this option. At time, BLAST extractor only can run with tabular file format. See BLAST+ Documentation to get help about tabular format.
To perform the sequences extraction you will need your **.FASTA file and the BLAST tabular results**.

**3.1**	Type the name of .FASTA file you want to use (example: ***M.musculus_NCBI_entire_genome.fasta***). Here is your query sequences.

**3.2**	Enter the name of file containing the **blast result in tabular format** (**outfmt6**, See BLAST+ Documentation to get help about tabular format).

**3.3**	Now you can choose a specific percentage to extract your sequences, you can type **help** and see all available options and you will see the screen bellow:
Bellow the **Help** page

	type  10  to get only the sequences that match with 10%	
	type  20  to get only the sequences that match with 20%	
	type  30  to get only the sequences that match with 30%		
	type  40  to get only the sequences that match with 40%		
	type  50  to get only the sequences that match with 50%		
	type  60  to get only the sequences that match with 60%		
	type  70  to get only the sequences that match with 70%		
	type  80  to get only the sequences that match with 80%		
	type  90  to get only the sequences that match with 90%		
	type  100  to get only the sequences that match with 100%
	type  10-100  to get only the sequences that match with 10% to 100% of hits	
	type  20-100  to get only the sequences that match with 20% to 100% of hits	
	type  30-100  to get only the sequences that match with 30% to 100% of hits	
	type  40-100  to get only the sequences that match with 40% to 100% of hits	
	type  50-100  to get only the sequences that match with 50% to 100% of hits	
	type  60-100  to get only the sequences that match with 60% to 100% of hits	
	type  70-100  to get only the sequences that match with 70% to 100% of hits	
	type  80-100  to get only the sequences that match with 80% to 100% of hits	
	type  90-100  to get only the sequences that match with 90% to 100% of hits	

	Or type all to no filter and get all sequences the match in the blast search.

## Running an example for BLAST+ analysis

The File **example_files.tar.gz** contains the following folders:

#### **M.musculus_data**
This folder contains two .FASTA files, the first ***M.musculus_NCBI_entire_genome.fasta*** is the complete genome of mouse (*Mus musculus*) with nucleotide sequences, this file can be used as **query** sequences for the **BLASTx/BLASTn** search. The second file in this folder is ***Mus_musculus_uniprot_swisprot.fasta*** that contains all available protein sequences of mouse obtained in **The universal protein resource (UniProt)** by searching for "mouse" in the search field and filtering the search to show only Reviewed sequences (http://www.uniprot.org/uniprot/?query=mouse&fil=reviewed%3Ayes&sort=score). This file can be used as **subject database** of BLASTx search (**-db**).

Using **Seqs-Extractor** you can run BLASTx search and easily generate the result file in all available BLAST+ formats, in this example we used the **option 6** to generate a tabular file, so the **Seqs-Extractor** run will result in the file **blastx-evalue_1e-3.outfmt6** 
NOTE: YOU CAN FIND THIS FILE IN THE FOLDER **Opt_1_2_3_BLAST_results**)

#### **M.musculus_100%_Extracted_seqs**
Here we used the **Seqs-Extractor** to extract from our **query** file (**M.musculus_NCBI_entire_genome.fasta**) only the top hits of **100%** of similarity that we get from the previous BLAST search. If you already runned a BLAST search, you can directly extract sequences, however your BLAST results file need to be in the tabular format. You can also run Seqs-Extractor to perform a BLAST search and extract sequences.

The folder **M.musculus_100%_Extracted_seqs** contains two files:
- The file bellow is a list containing the sequences IDs with 100% of similarity (according to BLASTx result) of **query vs subject database**.

    
    list_of_tophit-100%.txt

-   The file bellow contains the extracted sequences, only sequences that matched 100% against the **subject database**.


    seqs_only_the_tophit_100%_M.musculus_NCBI_entire_genome.fasta

#### **Opt_1_2_3_BLAST_results**
The folder **Opt_1_2_3_BLAST_results** contains the results of a BLASTx search performed in Seqs-Extractor using the following BLASTx parameters:

	$ makeblastdb -in Mus_musculus_uniprot_swisprot.fasta -dbtype prot

	$ blastx -query M.musculus_NCBI_entire_genome.fasta -db Mus_musculus_uniprot_swisprot.fasta -out blastx-evalue_1e-3.outfmt6 -evalue 1e-3 -num_threads 12 -outfmt 6
NOTE: The query fasta and the subject database used are in the folder **M.musculus_data**

## **4**. Just to perform extraction of sequences from a MISA file 
---------------------------------------------------------------

This option extract sequences that contain microssatellites from a **MISA file**, if you already performed a MISA search. 
To perform this option, you will need the .FASTA file containing all the sequences that you used to perform the MISA search and the file containing MISA results generated by the search.

**4.1** Type the name of the .FASTA file you want to use (example: **todos_um_e_dois.fasta**). Here is your query sequences.

**4.2** Enter the name of the file containing **MISA results**, corresponding to the sequences of the .FASTA file chosen in the topic **4.1** (example: ***todos_um_e_dois.fasta.misa***). 

NOTE: The file will be generated in .FASTA file and will be named as ***extracted-seqs.fasta***. It will be stored in your working folder.


## **5.** To perform a MISA search and extract sequences
-----------------------------------------------------
This option will run a **MISA search** and after will extract only the sequences containing the microssatelites found by the MISA search.

**5.1** Type the name of the .FASTA file that you want to use to run the **MISA search** (example: ***todos_um_e_dois.fasta***). Here is you query sequences.

After this phase you are ready, just wait and the **MISA results** will be generated in the same folder that you are working.
_____________________________________________
## **VERY IMPORTANT NOTE**
By default, you will use default MISA parameters to search for microssatelites. You can modify these parameters if you prefer to (see the section **8. Customize misa.ini file to modify parameters of microssatellites identification** of this manual).
_____________________________________________

The final screen will indicate the name of the files (**MISA results files** and the .FASTA file with the sequences extracted). The sequences in .FASTA file generated will be named with the ID of the sequences obtained from the input file **(For use in Trinity Differential Expression pipeline see the section 6 of this manual)**.


## **6.** Running MISA and extracting sequences maintaining the additional information in the title 
-----------------------------------------------------------------------------------------------

For users who needs to use extracted sequences of MISA search in Trinity RNA-Seq differential expression pipeline (Grabherr, M. G et al 2011) (https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-Differential-Expression), **Seqs-Extractor** allows a running-extraction that generates a .FASTA file whose sequences are named exactly as it was in the input file, maintaining additional information as **length** and **path** of the sequences in its titles.
NOTE: This option works only in RNA-Seq data assembled with Trinity (Grabherr, M. G et al 2011). 

**6.1** Type the name of the .FASTA file that you want to use to run the **MISA search** (example: ***assembled_by_Trinity.fasta***). Here is you query sequences.

The final screen will indicate the name of the files (**MISA results files** and the **.FASTA file with the sequences extracted**). The sequences in .FASTA file generated will be named with the full title of the sequence obtained from the input file. It will be stored in the same directory you are working.

## Running an example for MISA analysis

The folder **Opt_4_5_6_MISA_Examples** contain three files:

- **M.musculus_NCBI_entire_genome.fasta.misa** 
The file above is the MISA results performed over ***M.musculus_NCBI_entire_genome.fasta***

- **M.musculus_NCBI_entire_genome.fasta.statistics** 
The file above is the MISA statistics performed over ***M.musculus_NCBI_entire_genome.fasta***

-  **M.musculus_NCBI_entire_genome.fasta.MISA_extracted_seqs.fasta** 
The file above contains only the MISA positive sequences extracted by **Seqs-Extractor** from ***M.musculus_NCBI_entire_genome.fasta***

## **7.** Extracting sequences from any .FASTA file
-----------------------------------------------

This option allows you to extract sequences from any .FASTA file just using a text file containing a list with the IDs of the target sequences.
The ID of each sequence must be in a different line and begin with a **>** simbol.
EXAMPLE:

    >name_of_the_sequence01
    >name_of_the_sequence02
    >name_of_the_sequence03

**7.1** Type the name of the .FASTA file that you want to use. Here is your query sequences.

**7.2** Enter the name of the **text file** containing the IDs of the sequences that you want to extract.

The .FASTA file with only the sequences indicated by the **text file** will be stored in the same directory you are working. It will be named as bellow:
    
    name_of_text_file.name_of_the_input_fasta_file.extracted_seqs.fasta

## Running an example for extraction from any text file
The folder **Opt_7_Extract_from_txt_file** contain two files, the first **example_list.txt** is an example of a list to use in the extraction process and ***example_list.txt.M.musculus_NCBI_entire_genome.fasta.extracted_seqs.fasta*** is the result of extraction of sequences from **M.musculus_NCBI_entire_genome.fasta** using Seqs-Extractor. 

## **8.** Customize misa.ini file to modify parameters of microssatellites identification
---------------------------------------------------------------------------------------------

This option will open the **misa.ini** file in a text editor to allow you to modify the parameters of microssatellites identification.
- The first line of this file indicates the definitions of the unit to be considerated as a microssatelite. The first number refers to the number of nucleotides and the second number refers to the minimum 
value of repeat of that unit to be considerated as a microssatelite

Example: **2-6** indicates that **MISA** will considerate as microssatelite a pair of nucleotides that repeats at least six times in tandem.

- The second line of this file indicates the maximum number of nucleotides between two microssatellites, refering to compound microssatellites Example:

        100

After edit the file, you just have to hit **CTRL+S** to save the changes. See MISA documentation to learn more about this file. 
The new **misa.ini** file will be created in the working folder. It will be moved to **misa.ini.custom** folder after you run the option 5.


# **9.** Frequent asked questions(FAQ) and known bugs
----------------------------------------------
**Error**:

        misa.pl not found or misa.pl permission denied
**Solution**: Check if you are running the **Seqs-Extractor** in the same hard disk of your Linux system as well


 
## **10.** Third-party software that comes with Seqs-Extractor
------------------------------------------------------------
In this version of **Seqs-Extractor** we provide the off-line installers of the following third-party software:

NAME: misa.pl, Version 1.0, Available at http://pgrc.ipk-gatersleben.de/misa/misa.html 
NAME: BLAST+, Version 2.6.0, Available at ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/
NAME: SAMTOOLS, Version 1.4, Available at https://sourceforge.net/projects/samtools/files/samtools/1.4/
	
## **11.** REFERENCES 
-------------------

1.	Altschul, S. F., Gish, W., Miller, W., Myers, E. W., & Lipman, D. J. (1990). Basic local alignment search tool. Journal of molecular biology, 215(3), 403-410.
2.	Li, H., Handsaker, B., Wysoker, A., Fennell, T., Ruan, J., Homer, N., ... & Durbin, R. (2009). The sequence alignment/map format and SAMtools. Bioinformatics, 25(16), 2078-2079.
3.	Thiel, T. (2003). MISA—Microsatellite identification tool. Website http://pgrc. ipk-gatersleben. de/misa/[accessed 17 June 2016]. 
4.	Consortium, U. (2008). The universal protein resource UniProt. Nucleic acids research, 36, (suppl 1):D190-D195
5.	Grabherr, M. G., Haas, B. J., Yassour, M., Levin, J. Z., Thompson, D. A., Amit, I., ... & Chen, Z. (2011). Trinity: reconstructing a full-length transcriptome without a genome from RNA-Seq data. Nature biotechnology, 29(7), 644.
