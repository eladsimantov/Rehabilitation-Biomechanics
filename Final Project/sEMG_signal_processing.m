function [EMG_rect, EMG_env] = sEMG_signal_processing(RAW_EMG,fs,flpf,fhpf,nButter,window,PLOT_PSD)
    if PLOT_PSD==true
        newfigure("", "", "");
        pspectrum(RAW_EMG-mean(RAW_EMG), fs, "power", "FrequencyResolution",1)
        xline(flpf/1000, "--"); xline(fhpf/1000, "--")
        xlim([0, flpf/1000*1.25]); title("Power Spectrum of EMG signals"); legend("off")
    end
    fn=fs/2; % Nyquist Shanon Kuzbach
    [b,a] = butter(nButter, [fhpf, flpf]/fn, "bandpass"); 
    EMG_rect = abs(filtfilt(b,a,RAW_EMG-mean(RAW_EMG))); % remove bias, apply butterworth BPF and Full wave rectification
    EMG_env = sqrt(movmean(EMG_rect.^2, window)); % RMS moving average envelope
end