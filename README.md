# EMG-decomposition
Methods for detecting and classifying the motor unit (MU) firings from distinct MUs for EMG data recorded from indwelling electrodes.  
This process is known as MU decomposition.  In this project, concentrate on the classification stage of this process. 
In particular, I have developed a classifier using the technique of Hierarchical Agglomerative Clustering. 
My project will be to develop clustering code, and then evaluate my codes on real EMG data.
•	R00108_6.dat: The six second duration data file, sampled at 10,000 Hz.
•	R00108_6.hea: The corresponding header file for the record.
•	R00108_6truth.eaf: The “truth” decomposition annotation file.  The “time” field lists all of the true spike occurrence times and the “unit” field has all of the corresponding expert-identified MU classifications.  Use the “time” field as the starting point of my agglomerative clustering algorithm, since it gives me the time location of each spike. 
