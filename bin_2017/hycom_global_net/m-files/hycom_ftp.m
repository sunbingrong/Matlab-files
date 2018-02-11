% read the network HYCOM
clear;clc
HYCOM_global_url = 'ftp://ftp.hycom.org/datasets/GLBu0.08/expt_19.1/data/2012/hycom_GLBu0.08_191_2012010100_t000.nc';

        V = ncread(HYCOM_global_url,'water_v',[1 1 1 1],[1 1 1 1]);
