//---------------------------------------------------------------------------
//
// Name:        MainFrame.cpp
// Author:      Hao Tseng
// Created:     2009/8/6 
// Description: MainFrame class implementation
//
//---------------------------------------------------------------------------

#include "MainFrame.h"


BEGIN_EVENT_TABLE(MainFrame, wxFrame)
    EVT_MENU(ID_Quit, MainFrame::OnQuit)
    EVT_MENU(ID_About, MainFrame::OnAbout)
END_EVENT_TABLE()

MainFrame::MainFrame(const wxString& title, const wxPoint& pos, const wxSize& size)
: wxFrame((wxFrame *)NULL, -1, title, pos, size)
{
    wxMenu *menuFile = new wxMenu;

    menuFile->Append( ID_About, _T("&About...") );
    menuFile->AppendSeparator();
    menuFile->Append( ID_Quit, _T("E&xit") );

    wxMenuBar *menuBar = new wxMenuBar;
    menuBar->Append( menuFile, _T("&File") );

    SetMenuBar( menuBar );

    CreateStatusBar();
    SetStatusText( _T("Welcome to wxWindows!") );

    logBox = new wxTextCtrl(this, -1, wxEmptyString, wxDefaultPosition, wxDefaultSize, 
                            (wxTE_MULTILINE | wxTE_READONLY), wxDefaultValidator, wxEmptyString );
 
}

void MainFrame::OnQuit(wxCommandEvent& WXUNUSED(event))
{
    Close(TRUE);
}

void MainFrame::OnAbout(wxCommandEvent& WXUNUSED(event))
{
    logBox->AppendText("Add a message into logBox\n");
    wxMessageBox(_T("This is a wxWindows Hello world sample"),
        _T("About Hello World"), wxOK | wxICON_INFORMATION, this);
}

