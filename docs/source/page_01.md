---
layout: default
title: "retinocortex-EC"
---



# <span style="color:lightblue">Population receptive field mapping</span>

<hr style="border: 1px solid black; width:100%;"></hr>

![](/figures/BOLD.png){width="800px"  align=center}

## Introduction
Many studies have suggested a link between gamma oscillations and visual cognition. Using human ECoG and variety of visual images including gratings of different contrast, visual noise and naturalistic images, {cite:t}`Hermes2014` observed that gamma oscillations were strongly elicited by some spatial contrast patterns such as gratings but absent in others, like certain forms of visual noise or natural images —which would supposedly recruit gamma oscillations for their visual processing. From these results they concluded that gamma oscillations may not be necessary for seeing.  Trying to shed light on the matter, a subsequent study by {cite:t}`BRUNET2019635` used the same dataset but different analysis methods to explore an alternative hypothesis. Namely that, similarly to the spatial patterns elicited by gratings of different contrasts, local contrast structure on an image is directly related too to gamma activity. To measure this local contrast structure, they estimated the relative degree of focus (RDF) by computing the discrete cosine transform (DCT) of the image pixels, correlated this measure with gamma, and found a significant correlation (rho=0.63, p-value<000.1). From this they concluded that RDF could be considered a metric of contrast in natural images {cite:p}`BRUNET2019635`.

## Methods
Here, we further examine this question using a different stimulation protocol and recording technique. As a first assessment, we went into examining the relationship between RDF and spectral power in the gamma band (35 - 70 Hz) and calculated the correlation between gamma spectral power (% change from baseline) and RDF across all sites. Briefly, to estimate the RDF we computed the  DCT energy of a section of each image in the stimulus set that overlapped with each recording site's receptive field (RF), as follows. For each image (18 objects within their background) and recording site (12 depths comprising a cortical width between -550 and 550 ms) in a session (11 after their successful realignment to the granular layer), the centre and radius of the site's RF  were used to extract pixels comprising a square centred at the RF's centre. The square dimensions were twice the RF's size. The RF size was calculated as the standard deviation of its 2D Gaussian model. This provided us with a section of the image overlapping with each site's RF just enough to provide meaningful estimate of local contrast structure while avoiding the biasing influence in the DCT calculations of non-image grey pixels within the background. Subsequently, the resulting image's sections were transformed to grayscale and the DCT energy was computed for each site. This provided us with RDF estimates for each site and image.

## Results
|![](../../reports/figures/RDF_r.png){width="1000px" align=center} <details> <summary><span style="color:grey">With larger RF coverage:</span></summary>![](../../reports/figures/RDF_2r.png){width="1000px" align=center}</details>|
|:--:|
| **Correlation between RDF within the receptive field (RF-RDG) and gamma spectral power.**  We calculated Spearman's *rho* between these RDF estimates and gamma activity in the 35 - 70 Hz band pooled from a time window comprising 200 - 1200 ms after stimulus onset and found a smaller yet significant correlation (rho=0.11, p-value < 0.0001, N= *18 x 12 x 11*, *left panel*) than that reported in {cite:t}`BRUNET2019635`. Colors represent the image's RDF rank increase (from red to blue). We attribute this difference to the fact that our dataset is fundamentally different and may therefore reveal different aspects within the data. Whereas {cite:t}`Hermes2014` and {cite:t}`BRUNET2019635` used ECoG recordings which measure simultaneous patterns of activity along the cortical manifold, we pooled laminar recordings from recordings obtained in different sessions. Since each session allows descending a laminar electrode at a different cortical location in the cortical manifold a single time, our dataset provided us with an extra spatial dimension. This allowed us to examine neuronal activity patterns unfolding both in parallel and perpendicular to the cortical manifold. To examine the contribution of different spatial patterns into the RDF correlation, we then calculated Spearman's rho between RDF and gamma activity patterns pooled either across sessions (by averaging depths) or across depth (by averaging sessions).|

## Discussion
We found that the correlation between RDF and session-grouped sites was stronger than that between RDF and depth-grouped sites (rho=0.25, p-value < 0.0001, N= *18 x 11*, *central panel*). Our results confirm and extend equivalent results obtained by {cite:t}`BRUNET2019635` . Interestingly, the correlation between RDF and depth-grouped sites was negative (rho=-0.21, p-value < 0.005, N= *18 x 12*, *right panel*), suggesting a non-linear contribution of different layers to the correlation pattern. To examine this pattern, we analysed the relationship of RDF as a function of cortical depth and found that RDF was higher for granular layers, following a inverted U-shape, almost opposite to the U-shape distribution  of RF size found for this dataset. Our results corroborate a monotonic relationship between RDF and the amplitude of gamma oscillations, provided the RF size factor is averaged out. Otherwise this correlation is negative, pointing to an inverse relationship between RDF and RF size.




<details>
  <summary><span style="color:blue">Click here to see the RF overlap of each image and its relationship to the RDF</span></summary>

  ![](../../reports/figures/imageRF.png){height="500px"}![](../../reports/figures/chunks.png){height="490px"}

  <summary>All images</summary>

![](../../reports/figures/imagesRFs.png){width="1200px"}
</details>

## References


```{bibliography} references.bib
  :filter: docname in docnames  
```