// Function to plot N vs pT (transverse)

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

void N_vs_pT_Transverse_2040(){
    
    // Input dataset
    TFile *f=new TFile("13TeV_CR0_RHoff.root");
    // Input specific Tree
    TTree *tree = (TTree*)f->Get("pytree2040;28");
    // Find number of entries
    int entries = tree->GetEntries();

    // Upper limit of specific multiplicity class
    const int maxTrack=40;
   
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

    // Define the canvas
    TCanvas* c1 = new TCanvas("c1","N_vs_pT_Transverse_2040", 480, 360);
	//TLatex *t1 = new TLatex(3.5,0.6, "Toward Region");
	//t1->Draw();
	//TLatex *t2 = new TLatex(3.5,0.8, "|#eta| < 2.5 ");
	//t2->Draw();
    c1->SetFillColor(0);
    c1->SetBorderMode(0);
    c1->SetBorderSize(2);
    c1->SetTickx(1);
    c1->SetTicky(1);
    c1->SetFrameBorderMode(0);
    c1->SetFrameLineWidth(3);
    c1->SetFrameBorderMode(0);
    // Defining a 2 Dimensional Histogram
    TH2D* h = new TH2D("h","Average Number Density vs p_{T}^{lead} for multiplicity class 20 to 40 in Transverse Region",50,0,5,50,0,50);

    // Loop to fill (above) histogram
    for(int i=0; i<entries; i++){
    	tree->GetEntry(i);
    	double ntrks = ntrack;
		int maxindex = findmaxindex(pT,ntrack);
	double maxpT = pT[maxindex];
	double n_transverse=0;

	// Loop to find delta phi
    	for(int j=0; j<ntrks; j++) {
    		delphi[j] = diffangle(phi[j],phi[maxindex]);
    		if((delphi[j]<2*PI/3) && (delphi[j]>PI/3) && (eta[j]>-2.5 && eta[j]<2.5)){	
    			n_transverse++;
    		}
    	
    	}
	n_transverse = n_transverse*3/(5*PI);
	h->Fill(maxpT,n_transverse);
    }

// To calculate mean in a 2D histogram
TProfile* profile = h->ProfileX();
profile->SetStats(0);
profile->SetLineColor(2);
profile->SetLineWidth(2);
profile->GetXaxis()->SetTitle("p_{T}^{lead} [GeV]");
profile->GetXaxis()->CenterTitle(true);
profile->GetXaxis()->SetLabelFont(42);
profile->GetXaxis()->SetTitleSize(0.04);
profile->GetXaxis()->SetTitleOffset(1);
profile->GetXaxis()->SetTitleFont(42);
profile->GetYaxis()->SetTitle("<d^{2}N_{ch}/d#etad#phi>");
profile->GetYaxis()->CenterTitle(true);
profile->GetYaxis()->SetLabelFont(42);
profile->GetYaxis()->SetTitleSize(0.04);
profile->GetYaxis()->SetTitleFont(42);
profile->GetZaxis()->SetLabelFont(42);
profile->GetZaxis()->SetTitleOffset(1);
profile->GetZaxis()->SetTitleFont(42);
profile -> Draw("HIST");
};
