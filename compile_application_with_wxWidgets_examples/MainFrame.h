//---------------------------------------------------------------------------
//
// Name:        MainFrame.h
// Author:      Hao Tseng
// Created:     2009/8/6 
// Description: MainFrame class declaration
//
//---------------------------------------------------------------------------
#ifndef __MAINFRAME_H
#define __MAINFRAME_H

#include "wx/wx.h"

class MainFrame: public wxFrame
{
public:

    MainFrame(const wxString& title, const wxPoint& pos, const wxSize& size);

    void OnQuit(wxCommandEvent& event);
    void OnAbout(wxCommandEvent& event);

    DECLARE_EVENT_TABLE();
    
private:
    wxTextCtrl  *logBox;
};

enum
{
    ID_Quit = 1,
    ID_About,
};

#endif
