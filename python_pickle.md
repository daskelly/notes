# How to pickle in python

I always forget how to do this

```python
import pickle

f = open('file.pkl', 'wb')
pickle.dump(obj, f)
f.close()

infile = open('file.pkl', 'rb')
obj = pickle.load(infile)
infile.close()
````

That's it!
