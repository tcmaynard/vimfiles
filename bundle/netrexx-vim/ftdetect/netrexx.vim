" Vim filetype plugin file
" Language:	NetRexx
" Maintainer:	Rene Jansen <rvjansen@rvjansen.com> Thomas Geulig <geulig@nentec.de>
" Last Change:  2005 Dez  9, added some <http://www.ooRexx.org>-coloring,
"                            line comments, do *over*, messages, directives,
"                            highlighting classes, methods, routines and requires
"               2007 Oct 17, added support for new ooRexx 3.2 features
"               Rony G. Flatscher <rony.flatscher@wu-wien.ac.at>
"               2015 May 08 - [TCM] - restructured for Pathogen compatibility
"
" URL:		http://www.geulig.de/vim/rexx.vim
"
" Special Thanks to Dan Sharp <dwsharp@hotmail.com> and Rony G. Flatscher
" <Rony.Flatscher@wu-wien.ac.at> for comments and additions

au BufNewFile,BufRead *.nrx set filetype=netrexx syntax=netrexx
