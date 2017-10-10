Version 0.9.0(BETA) (Jan 23, 2017) Copyright (c) 2017 By Patrick Douglas email: patrick@ufpa.br 
BLAST Extractor home page: https://blast-extractor.sourceforge.io

# Important Notice
This program is distributed in the hope that it will be useful,	but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
See the	GNU General Public License for more details.

# What Is Blast Extractor ?
A simple tool to help extraction of BLASTed sequences using the tabular BLAST file and query sequences, producing a fasta file containing only sequences that matched with 
a specific percentage defined by the user. This software also turns BLAST command line more friendly.

It works with shell bash. BLAST Extractor is developed for Linux, it should also work with any UNIX operating system with Debian based and was tested under 
Linux Mint 17.3 xfce and Ubuntu 16.4 LTs.

# Minimum System Requirements
	- Linux Debian based operating system.

# Documentations in the Distribution
	README		Program usage 
	INSTALL		Installation procedure
	HOW TO USE	General instructions about usage
	REFERENCES	Third-party software used by BLAST Extractor

# Blast-Extractor
# How to install, uninstall or reinstall:

Open a terminal window and type the following commands:

	$ sudo -i

	$ cd *to folder where you unpack the software files*

	$ ./installer.sh


You will be asked to choose an option as bellow:
------------------------------------------------
	1 To install BLAST Extractor
	2 To uninstall BLAST Extractor
	3 To reinstall BLAST Extractor

	By using option 1 or 3, you agree with the installation of BLAST+ standalone tools (Altschul, et al 1990) and SAMTOOLS (Li, et al., 2009), which are required to some analyses. 
	
How to run
==========

Open a terminal window and type:
--------------------------------

blast-extractor

Or just open BLAST-Extractor from Linux main menu
-------------------------------------------------


#The work folder
To start you will need to choose a folder to work. Is usually the directory where your files are, the results will be generated in this directory.

Please use the following format:

	/home/user/example/

If you leave this in blank the software will use your $HOME folder as default

To use a file that is not in the working folder, enter the path with the file name, example:

	/home/user/example/example.fasta

#How to use
**1.**	Just to perform a BLAST search:
------------------------------------
This option will perform a BLAST search using NCBI-BLAST+.


**1.1** 	You will be asked to choose between BLASTn or BLASTx (Others BLAST+ tools are not available at this moment).

**1.2** 	Type the name of fasta file you want to use in the BLAST search (example: M.musculus_NCBI_entire_genome.fasta). Here is your query sequences.

**1.3** 	You will decide to format a BLAST database or to use an already formatted (see NCBI BLAST+ documentation to more details). 
	1.3.1	[FORMAT A BLAST DATABASE] Enter the name of fasta file that you want to format (example: Mus_musculus_uniprot_swisprot.fasta):
		1.3.1.1	The software will run the following command to format BLAST database:
			This command will be performed automatically and depends of your choice in item 1.1 
			IF YOU DECIDE TO USE BLASTx
			$ makeblastdb -in name_of_your_database_to_BLAST.fasta -dbtype prot

			IF YOU DECIDE TO USE BLASTn
			$ makeblastdb -in name_of_your_database_to_BLAST.fasta -dbtype nucl

	1.3.2	[USE A DATABASE ALREADY FORMATTED] Enter the name of fasta file you want to use as BLAST preformated database
		This command is useful if you already performed *makeblastdb* command and do not want run it again.


**1.4**	Enter the expected value (E-value) that you want to use in the BLAST search (example: 1e-20).

**1.5**	Enter how many CPU-cores you want to use in the BLAST search.

**1.6**	Enter the format of BLAST results output file you want to be generated (example: type 6 to generate a file in tabular format). Here you can type help to get all available formats, or you can read the BLAST+ documentation to get help.

**1.7**	In this phase you can insert additional BLAST parameters separated by spaces and starting with dashes, or you can just hit ENTER key to skip 
Example: -max_target_seqs 1 -num_descriptions 10

**1.8**	Some BLAST parameters are required to use these tools, they are:

	-query			Your fasta file

	-db 			The database to BLAST

	-E-value 		The expected value of BLAST search

	-num_threads 	The number of CPU cores to parallel processing of BLAST search

	-outfmt			The output format of BLAST results

However, you can add other BLAST parameters (see topic **1.7** of this manual)

After this phase you are ready, just wait and the BLAST results will be generated in the same folder that you are working.
This can take a long time and depends of the size of your datasets (query.fasta and database).
The file will be named as follows:
	BLAST-evalue.outfmt

**2.** BLAST and extract the sequences
--------------------------------------
This option will perform a BLAST search using NCBI-BLAST+ and after it will extract only the sequences that match with the subject database, in a specific percentage defined by the user.

EXAMPLE: After a BLAST run you can use the tabular BLAST format to extract from your query dataset only the sequences that match in a specific percentage of hits, like 100%.

**2.1**	You will be asked to choose between BLASTn or BLASTx (Others BLAST+ tools are not available at this moment).

**2.2**	Type the name of fasta file you want to use in the BLAST search (example: M.musculus_NCBI_entire_genome.fasta). Here is your query sequences.

**2.3**	You will decide to format a BLAST database or to use an already formatted (see NCBI BLAST+ documentation to more details). 
	
	2.3.1	[FORMAT A BLAST DATABASE] Enter the name of fasta file that you want to format (example: Mus_musculus_uniprot_swisprot.fasta):

		2.3.1.1	The software will run the following command to format BLAST database:
			This command will be performed automatically and depends of your choice in item 2.1 
			IF YOU DECIDE TO USE BLASTx
			$ makeblastdb -in name_of_your_database_to_BLAST.fasta -dbtype prot

			IF YOU DECIDE TO USE BLASTn
			$ makeblastdb -in name_of_your_database_to_BLAST.fasta -dbtype nucl

	2.3.2	[USE A DATABASE ALREADY FORMATTED] Enter the name of fasta file you want to use as BLAST preformated database
		This command is useful if you already performed *makeblastdb* command and do not want run it again.
	
**2.4**	In this phase you can insert additional BLAST parameters separated by spaces and starting with dashes, or you can just hit ENTER key to skip 

EXAMPLE: -max_target_seqs 1 -num_descriptions 10

**2.5**	Some BLAST parameters are required to use these tools, they are:

	-query			Your fasta file

	-db 			The database to BLAST

	-E-value 		The expected value of BLAST search

	-num_threads 	The number of CPU cores to parallel processing of BLAST search

	-outfmt			The output format of BLAST results

However, you can add other BLAST parameters (see topic **2.4** of this manual)

**2.6**	Now you can choose a specific percentage to extract your sequences, you can type help and see all available options and you will see the screen bellow:

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

**2.7**	The final screen will indicate the name of files, the created database files will be stored in the same directory you are working and you can delete it if you prefer to.


**3.** To perform extraction without run a BLAST search 
--------------------------------------------------
You can also only extract, if you already performed a BLAST search, however you will need a tabular BLAST results file (choose the option 6 for generate an output file in this format) to use this option. At time, BLAST extractor only can run with tabular file format. See BLAST+ Documentation to get help about tabular format.
To perform the sequences extraction you will need your fasta file and the BLAST tabular results.

**3.1**	Type the name of fasta file you want to use (example: M.musculus_NCBI_entire_genome.fasta). Here is your query sequences.

**3.2**	Enter the name of file containing the blast result in tabular format (outfmt6, See BLAST+ Documentation to get help about tabular format).

**3.3**	Choose a specific percentage to extract your sequences, you can type help and see all available options, you will see the screen bellow:

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

#RUNNING AN EXAMPLE 

The File **example_files.zip** contains the following folders:

**BLASTX_results**
------------------

The folder **BLASTX_results** contains the results of a BLASTx search performed in BLAST Extractor using the following BLASTx parameters:

	$ makeblastdb -in Mus_musculus_uniprot_swisprot.fasta -dbtype prot

	$ blastx -query M.musculus_NCBI_entire_genome.fasta -db Mus_musculus_uniprot_swisprot.fasta -out blastx-evalue_1e-3.outfmt6 -evalue 1e-3 -num_threads 12 -outfmt 6

NOTE: The query fasta and the subject database used are in the folder **M.musculus_data**

**M.musculus_data:**
--------------------
This folder contains two fasta files, the first **M.musculus_NCBI_entire_genome.fasta** is the complete genome of mouse (*Mus musculus*) 
with nucleotide sequences, this file can be used as **query** sequences for the BLASTx/BLASTn search. The second file in this folder is **Mus_musculus_uniprot_swisprot.fasta** 
that contains the all available protein sequences of mouse obtained in The universal protein resource (UniProt) by searching for "mouse" in the search field and filtering the search to show only 
Reviewed sequences (http://www.uniprot.org/uniprot/?query=mouse&fil=reviewed%3Ayes&sort=score). This file can be used as subject database of BLASTx search (**-db**).

With BLAST Extractor you can run BLASTx search and easily generate the result file in all available BLAST+ formats, in this example we used the option 6 to generate a tabular
file, so the BLAST Extractor run will result in the file **blastx-evalue_1e-3.outfmt6** (**NOTE: YOU CAN FIND THIS FILE IN THE *BLASTX_results* folder)


**M.musculus_100%_Extracted_seqs**
----------------------------------
Here we used the BLAST Extractor to extract from our query file (**M.musculus_NCBI_entire_genome.fasta**) only the top hits of 100% of similarity that we get from the previous 
BLAST search. If you already runned a BLAST search, you can directly extract sequences, however your BLAST results file need to be in the tabular format. 
You can also run BLAST Extractor to perform a BLAST search and extract sequences.

This folder contains two files: 
**list_of_tophit-100%.txt** : List containing the sequences IDs with 100% of similarity (according to BLASTx results) of ***query vs subject database***

**seqs_only_the_tophit_100%_M.musculus_NCBI_entire_genome.fasta** : This file contains the extracted sequences, only sequences that matched 100% against the subject database.


#Support, feedback or questions to **patrick@ufpa.br**


**4.** REFERENCES 

	1.	Altschul, S. F., Gish, W., Miller, W., Myers, E. W., & Lipman, D. J. (1990). Basic local alignment search tool. Journal of molecular biology, 215(3), 403-410.

	2.	Li, H., Handsaker, B., Wysoker, A., Fennell, T., Ruan, J., Homer, N., ... & Durbin, R. (2009). The sequence alignment/map format and SAMtools. Bioinformatics, 25(16), 2078-2079.
 
	3.	Consortium, U. (2008). The universal protein resource UniProt. Nucleic acids research, 36, (suppl 1):D190-D195
