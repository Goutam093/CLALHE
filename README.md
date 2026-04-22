# 📌 CLALHE: Contrast Limited Adaptive Local Histogram Equalization

## 📖 Overview

This project implements **Contrast Limited Adaptive Local Histogram Equalization (CLALHE)**, an advanced image enhancement technique used to improve contrast in low-quality or poorly illuminated images.

CLALHE enhances images by applying adaptive histogram equalization locally on sub-images while limiting noise amplification, producing clearer and more detailed outputs. ([DOAJ][1])

---

## 🚀 Features

* Adaptive contrast enhancement
* Works on local image regions (sub-images)
* Reduces noise amplification compared to standard histogram equalization
* Supports batch processing of images
* Generates performance metrics and visual comparisons

---

## 🛠️ Tech Stack

* MATLAB / Octave
* Image Processing Toolbox

---

## 📂 Project Structure

```
├── main.m                         # Main execution file
├── batch_process.m               # Process multiple images
├── clalhe.m                      # Core CLALHE algorithm
├── apply_conventional_clahe.m    # CLAHE implementation
├── divide_image.m                # Split image into sub-images
├── merge_subimages.m             # Merge processed sub-images
├── compute_histogram_features.m  # Histogram-based features
├── compute_ciqi.m                # Contrast Improvement Index
├── compute_metrics.m             # Evaluation metrics
├── plot_histogram_comparison.m   # Histogram visualization
├── test_images/                  # Input images
├── results/                      # Output results
└── README.md
```

---

## ⚙️ How It Works

1. Input image is divided into smaller sub-images
2. Each sub-image is enhanced using adaptive histogram equalization
3. Contrast limiting is applied to avoid noise amplification
4. Enhanced sub-images are merged
5. Final image is evaluated using quality metrics

---

## 📊 Metrics Used

* PSNR (Peak Signal-to-Noise Ratio)
* SSIM (Structural Similarity Index)
* Entropy
* AMBE (Absolute Mean Brightness Error)
* RMSE (Root Mean Square Error)
* CII (Contrast Improvement Index)

---

## ▶️ How to Run

### 1. Clone the repository

```bash
git clone https://github.com/Goutam093/CLALHE.git
cd CLALHE
```

### 2. Run the main script

```matlab
main
```

### 3. Batch processing (optional)

```matlab
batch_process
```

---

## 🖼️ Input & Output

* Place test images inside `test_images/`
* Results will be saved in `results/`

---

## 📈 Applications

* Medical image enhancement
* Low-light photography
* Satellite imaging
* Face and object detection preprocessing

---

## 🔬 Algorithm Insight

CLALHE improves upon traditional CLAHE by:

* Automatically selecting optimal parameters
* Applying enhancement locally
* Preserving brightness while improving contrast

---

## 🤝 Contributing

Contributions are welcome!
Feel free to fork the repository and submit a pull request.
