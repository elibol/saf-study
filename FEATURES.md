# Feature Classes

* **Physical Force**: This is our target variable.

* **Something Found**: Might be interesting to use as a target variable, to see how good officers
  are at identifying suspects.

* **Arrest Made / Reason for Arrest**: If we can narrow the number of things an arrest was made for,
  perhaps we can do something useful with these variables. For instance,
  we might be interested in whether na arrest was made even though nothing was found
  on suspect (something pertaining to non-compliance).

* **Reason for Frisk**: This is important. **How is this different than basis of search**?

* **Frisked / Searched**: Will likely have high correlation with Physical Force.
  Any reason we might not expect this to be 100% correlated with physical force (i.e.
  it's always true the suspect is searched whenever physical force is used)? This type of
  strong correlation => low predictive information.

* **Time of Day**: Maybe we use data to produce a categorical variable indicating whether
it's night time.

* **Location**: May be important, but we'd need reliable data about these locations 
if we're to make any use of this variable.

* **Suspect Details**: Several variables indicating demographic. Super important. We'll
  want to compare these to other variables that have high correlation with our target variable.
  We'll also want to see the correlation between other variables and this variable.

* **Officer Details**: What was the officer's command? Was officer in uniform?
  These might be interseting to
  play around with.
  Would be nice to have demogrpahic info on officers (race, sex, etc.).
  
* **Reason Force Used**: This is also very intersting, especially if we can distill this as 
  something categorical.


# Questions

* Anything useful we can infer from "additional circumstances"?
* Anything useful from time of year or day of week?
* Any correlation with inside/outside and other variables?
* Which confounding variables are not present in this data? So far,
  nothing comes to mind that we can't cover with this data.

# Stop and Frisk Procedure

Bsaed on this data (perhas the process is documented somewhere),
we can deduce a process that looks and may escalate as folows:

1. Officer stops a suspect for some reason.
2. Officer may frisk the suspect for some reason.
3. Officer may arrest the suspeect for some reason.

# Feature Breakdown

Variables to be used in analysis formatted as follows:
* `{variable}` {ROLE}
    * `{raw variable 1}`
    * `{raw variable 2}`

Where `{variable}` is the name of the variable to be used in the model,
and `{raw variable i}` indicates the variables used to determine the value of
`{variable}`.


{ROLE} is any one of the following:
* **TARGET**: The target/dependent variable (typically thought of as the y value).
* **POSITIVE**: Thought to be positively correlated with the target variable.
* **NEGATIVE**: Thought to be negatively correlated with target variable.


* `force_used` TARGET

* `something_found`
  * `contrabn`
  

# Correlation Heat Map

Once we have all our variables, we'll want to look at how variables are correlated, and report on that.
See http://www.r-bloggers.com/using-r-correlation-heatmap-take-2/

