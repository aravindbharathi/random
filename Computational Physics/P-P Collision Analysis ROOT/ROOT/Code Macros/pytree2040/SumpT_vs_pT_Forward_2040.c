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

void SumpT_vs_pT_Forward_2040(){

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

    // Setting Branch Address for each leaf
    tree->SetBranchAddress("ntrack",&ntrack);
    tree->SetBranchAddress("phi",&phi);
    tree->SetBranchAddress("pT",&pT);
    tree->SetBranchAddress("eta",&eta);

    TCanvas* c1 = new TCanvas("c1","SumpT_vs_pT_Forward_2040", 480, 360);
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

    // Define a 2 Dimensional Histogram
    TH2D* h = new TH2D("h","Average #sump_{T} vs p_{T}^{lead} for multiplicity class 20 to 40 in Toward Region",50,0,5,50,0,50);

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
profile->SetLineColor(2);
profile->SetLineWidth(2);
profile->GetXaxis()->SetTitle("p_{T}^{lead} [GeV]");
profile->GetXaxis()->CenterTitle(true);
profile->GetXaxis()->SetLabelFont(42);
profile->GetXaxis()->SetTitleSize(0.04);
profile->GetXaxis()->SetTitleOffset(1);
profile->GetXaxis()->SetTitleFont(42);
profile->GetYaxis()->SetTitle("<d^{2}#sump_{T}/d#etad#phi> [GeV]");
profile->GetYaxis()->CenterTitle(true);
profile->GetYaxis()->SetLabelFont(42);
profile->GetYaxis()->SetTitleSize(0.04);
profile->GetYaxis()->SetTitleFont(42);
profile->GetZaxis()->SetLabelFont(42);
profile->GetZaxis()->SetTitleOffset(1);
profile->GetZaxis()->SetTitleFont(42);
profile -> Draw("HIST");
};
