// Function to plot Frequency vs Delta Phi

#include "TH1.h"
#include "TH2.h"
#include "THnSparse.h"
#include "TRandom.h"
#include "TCanvas.h"
#include "TFile.h"
#include "TStyle.h"
#include "TTree.h"
#include "TSystem.h"
#include "math.h"

// Define constant PI
#define PI 3.14159265358979

// Function to find maximum index value
int findmaxindex(double * arr, int length){
	double maxvalue = arr[0];
	int maxindex = 0;
	for(int i = 1; i < length; i++){
		if(arr[i] > maxvalue){
			maxvalue = arr[i];
			maxindex = i;
		}
	}
	return maxindex;
}

// Function to calculate the difference in angles
double diffangle(double phi1, double phi2){
	double diffphi = abs(phi1 - phi2);
	if(diffphi > PI){
		return (2*PI - diffphi);
	}
	else{
		return diffphi;
	}
}

void Nu_vs_delphi(){

    // Input dataset
    TFile *f=new TFile("13TeV_CR0_RHoff.root");
    // Input specific Tree
    TTree *tree = (TTree*)f->Get("pytree6080;16");
    // Find number of entries
    int entries = tree->GetEntries();

    // Upper limit of specific multiplicity class
    const int maxTrack=80;
   
    // Defining necessary variables to input values in dataset
    int ntrack = 0;
    double pT[maxTrack];
    double eta[maxTrack];
    double rap[maxTrack];
    double phi[maxTrack];
    double delphi[maxTrack];

    // Setting Branch Address for each leaf
    tree->SetBranchAddress("ntrack",&ntrack);
    tree->SetBranchAddress("phi",&phi);
    tree->SetBranchAddress("pT",&pT);
    tree->SetBranchAddress("eta",&eta);

    // Define a 1 Dimensional Histogram
    TH1D* hdelphi = new TH1D("hdelphi","delta phi",100,0,PI);

    // Loop to fill (above) histogram
    for(int i=0; i<entries; i++){
    	tree->GetEntry(i);
    	int ntrks = ntrack;
    	int maxindex = findmaxindex(pT,ntrks);

	// Loop to find delta phi
    	for(int j=0; j<ntrks; j++) {
    		delphi[j] = diffangle(phi[j],phi[maxindex]);
    		if(j != maxindex){	
    			hdelphi -> Fill(delphi[j]);
    		}
    	}
    }

    // Normalizing the histogram
    hdelphi->Scale(1.0/hdelphi->GetMaximum());
    // Settings the range of axes
    hdelphi->SetAxisRange(0., 1.,"Y");
    hdelphi -> Draw("HIST");
}