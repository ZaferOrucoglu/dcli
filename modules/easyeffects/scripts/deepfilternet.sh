#!/usr/bin/env bash 
curl -LO --output-dir /tmp https://github.com/Rikorose/DeepFilterNet/releases/download/v0.5.6/libdeep_filter_ladspa-0.5.6-x86_64-unknown-linux-gnu.so
sudo mv -v /tmp/libdeep_filter_ladspa-0.5.6-x86_64-unknown-linux-gnu.so /usr/lib64/ladspa/libdeep_filter_ladspa.so


if [ -f "/usr/lib64/ladspa/libdeep_filter_ladspa.so" ]; then
    echo "DeepFilterNet installed Successfully"
fi
