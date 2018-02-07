<?php

/* $Id: PDFStarter.php 3526 2010-06-26 08:05:36Z tim_schofield $ */

/*	-------------------------------------------------------------------------------------
	November 2009. Moving from FPDF to TCPDF.
 	This file is included by most of the scripts (47 from 54 at now) that creates a pdf.
	This file creates a new instance of the PDF object defined in class.pdf.php
	The changes applied to the PDF class affected this file that needed some changes too.
	Javier de Lorenzo-Cáceres <info@civicom.eu>
	------------------------------------------------------------------------------------- */


require_once (dirname(__FILE__).'/class.pdf.php');

/*
//	Changes to move from FPDF to TCPDF to support UTF-8 by Javier de Lorenzo-Cáceres <info@civicom.eu>
*/

if (!isset($PaperSize)){				// Javier: Results True, it's not set.
	$PaperSize = 'A4';	// Javier: DefaultPageSize is taken from DB, www_users, pagesize = A4
}

/* Javier: TCPDF supports 45 standard ISO (DIN) paper formats and 4 american common formats and does this cordinates calculation.
		However, reports use this units */

	$DocumentPaper = 'A4'; $DocumentOrientation ='P';

// Javier: DIN-A4 is 210 mm width, i.e., 595'2756 points (inches * 72 ppi)
     $Page_Width=842;
	$Page_Height=595;
	$Top_Margin=0;
	$Bottom_Margin=20;
	$Left_Margin=25;
	$Right_Margin=22;
      

  

// Javier: I correct the call to the constructor to match TCPDF (and FPDF ;-)
//	$PageSize = array(0,0,$Page_Width,$Page_Height);
//	$pdf = new Cpdf($PageSize);
$pdf = new Cpdf($DocumentOrientation, 'pt', $DocumentPaper);


/* Javier: I have brought this piece from the pdf class constructor to get it closer to the admin/user,
	I corrected it to match TCPDF, but it still needs check, after which,
	I think it should be moved to each report to provide flexible Document Header and Margins in a per-report basis. */
 	$pdf->SetAutoPageBreak(true, 0);	// Javier: needs check.
	$pdf->SetPrintHeader(false);	// Javier: I added this must be called before Add Page
	$resolution= array(1024, 768);
	$pdf->AddPage('P', $resolution);
//	$this->SetLineWidth(1); 	   Javier: It was ok for FPDF but now is too gross with TCPDF. TCPDF defaults to 0'57 pt (0'2 mm) which is ok.
	$pdf->cMargin = 0;		// Javier: needs check.
/* END Brought from class.pdf.php constructor */

?>
