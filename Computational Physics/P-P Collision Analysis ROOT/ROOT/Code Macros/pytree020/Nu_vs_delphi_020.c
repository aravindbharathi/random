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

void Nu_vs_delphi_020(){

    // Input dataset
    TFile *f=new TFile("13TeV_CR0_RHoff.root");
    // Input specific Tree
    TTree *tree = (TTree*)f->Get("pytree020;24");
    // Find number of entries
    int entries = tree->GetEntries();

    // Upper limit of specific multiplicity class
    const int maxTrack=20;
   
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

    // Define the canvas
    TCanvas* c1 = new TCanvas("c1","Delta phi", 480, 360);
    c1->SetFillColor(0);
    c1->SetBorderMode(0);
    c1->SetBorderSize(2);
    c1->SetTickx(1);
    c1->SetTicky(1);
    c1->SetFrameBorderMode(0);
    c1->SetFrameLineWidth(3);
    c1->SetFrameBorderMode(0);
    // Define a 1 Dimensional Histogram
    TH1D* hdelphi = new TH1D("hdelphi","#Delta#phi for multiplicity class 0 to 20",100,0,PI);

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
    //hdelphi->SetAxisRange(0., 1.,"Y");
    hdelphi->SetMinimum(0);
    hdelphi->SetMaximum(1);
    hdelphi->SetEntries(2.158218e+07);
    hdelphi->SetStats(0);
    hdelphi->SetLineColor(2);
    hdelphi->SetLineWidth(2);
    hdelphi->GetXaxis()->SetTitle("#Delta#phi");
    hdelphi->GetXaxis()->CenterTitle(true);
    hdelphi->GetXaxis()->SetLabelFont(42);
    hdelphi->GetXaxis()->SetTitleSize(0.04);
    hdelphi->GetXaxis()->SetTitleOffset(1);
    hdelphi->GetXaxis()->SetTitleFont(42);
    hdelphi->GetYaxis()->SetTitle("Frequency");
    hdelphi->GetYaxis()->CenterTitle(true);
    hdelphi->GetYaxis()->SetLabelFont(42);
    hdelphi->GetYaxis()->SetTitleSize(0.04);
    hdelphi->GetYaxis()->SetTitleFont(42);
    hdelphi->GetZaxis()->SetLabelFont(42);
    hdelphi->GetZaxis()->SetTitleOffset(1);
    hdelphi->GetZaxis()->SetTitleFont(42);
    hdelphi->Draw("HIST");
}