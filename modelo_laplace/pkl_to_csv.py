import pickle as pkl
import pandas as pd
import sys

#python3 pkl_to_csv.py <input> <output>

with open(str(sys.argv[1]), "rb") as f:
    object = pkl.load(f)

df = pd.DataFrame(object,index=[0])
df.to_csv(str(sys.argv[2]))
