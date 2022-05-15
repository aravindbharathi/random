// Function to plot N vs pT (backward)

#include "TH1.h"
#include "TH2.h"
#include "THnSparse.h"
#include "TRandom.h"
#include "TCanvas.h"
#include "TFile.h"
#include "TStyle.h"
#include "TTree.h"
#include "TSystem.h"
#include "TProfile.h"
#include "math.h"

// Define constant PI
#define PI 3.14159265358979

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

double diffangle(double phi1, double phi2){
	double diffphi = abs(phi1 - phi2);
	if(diffphi > PI){
		return (2*PI - diffphi);
	}
	else{
		return diffphi;
	}
}

void N_vs_pT_backward(){
    
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

    // Setting Branch Address of each leaf
    tree->SetBranchAddress("ntrack",&ntrack);
    tree->SetBranchAddress("phi",&phi);
    tree->SetBranchAddress("pT",&pT);
    tree->SetBranchAddress("eta",&eta);

    // Defining a 2 Dimensional Histogram
    TH2D* h = new TH2D("h","N vs pT backward",50,0,5,50,0,50);

    // Loop to fill (above) histogram
    for(int i=0; i<entries; i++){
    	tree->GetEntry(i);
    	double ntrks = ntrack;
		int maxindex = findmaxindex(pT,ntrack);
	double maxpT = pT[maxindex];
	double n_backward=0;

	// Loop to find delta phi
    	for(int j=0; j<ntrks; j++) {
    		delphi[j] = diffangle(phi[j],phi[maxindex]);
    		if((delphi[j]>2*PI/3) && (eta[j]>-2.5 && eta[j]<2.5)){	
    			n_backward++;
    		}
    	
    	}
	n_backward = n_backward*3/(5*PI);
	h->Fill(maxpT,n_backward);
    }

// To calculate mean in a 2D histogram
TProfile* profile = h->ProfileX();
profile->SetStats(0);
profile -> Draw("HIST");
};