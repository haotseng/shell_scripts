//---------------------------------------------------------------------------
//
// Name:        MainApp.cpp
// Author:      Hao Tseng
// Created:     2009/8/6 
// Description: MainApp class implementation
//
//---------------------------------------------------------------------------

#include "MainApp.h"
#include "MainFrame.h"

IMPLEMENT_APP(MainApp)

bool MainApp::OnInit()
{
    MainFrame *frame = new MainFrame( _T("Hello World"), wxPoint(50,50), wxSize(450,340) );
    frame->Show(TRUE);
    SetTopWindow(frame);
    return TRUE;
} 
