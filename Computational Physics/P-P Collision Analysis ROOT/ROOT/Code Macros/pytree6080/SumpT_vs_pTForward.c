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

void SumpT_vs_pTForward(){

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
    double phi[maxTrack];
    double delphi[maxTrack];

    // Setting Branch Address for each leaf
    tree->SetBranchAddress("ntrack",&ntrack);
    tree->SetBranchAddress("phi",&phi);
    tree->SetBranchAddress("pT",&pT);
    tree->SetBranchAddress("eta",&eta);

    // Define a 2 Dimensional Histogram
    TH2D* h = new TH2D("h","Sum pT vs pT forward",50,0,5,50,0,50);

    for(int i=0; i<entries; i++){
    	tree->GetEntry(i);
    	double ntrks = ntrack;
	int maxindex = findmaxindex(pT,ntrack);
	double maxpT = pT[maxindex];
	double sum_pT=0;
    	for(int j=0; j<ntrks; j++) {
    		delphi[j] = diffangle(phi[j],phi[maxindex]);
    		if((delphi[j]<PI/3) && (eta[j]>-2.5) && (eta[j]<2.5)){	
    			sum_pT = sum_pT + pT[j];
    		}
    	}
	sum_pT = sum_pT*3/(5*PI);
	h->Fill(maxpT,sum_pT);
    }

// Finding mean of 2D histogram
TProfile* profile = h->ProfileX();
profile->SetStats(0);
profile -> Draw("HIST");
};