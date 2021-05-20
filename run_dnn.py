import tensorflow as tf
import keras
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten
import numpy as np
from sklearn.utils import shuffle
from sklearn.metrics import roc_curve
from sklearn.metrics import auc
import argparse
parser = argparse.ArgumentParser(description='Process input files and parameters.')
parser.add_argument('-x', '--trnx', type=str, required=True, help="training features")
parser.add_argument('-y', '--trny', type=str, required=True, help="training outcomes")
parser.add_argument('-v', '--valid', type=str, required=False, help="validation ratio")
parser.add_argument('-t', '--test', type=str, required=False, help="test ratio")
parser.add_argument('-r', '--rate', type=float, required=False, help="learning rate")
parser.add_argument('-c', '--epochs', type=int, required=False, help="number of epochs")
parser.add_argument('-b', '--batch_size', type=int, required=False, help="batch size")
parser.add_argument('-d1', '--dense1', required=False, help="units of first dense layer")
parser.add_argument('-d2', '--dense2', required=False, help="units of second dense layer")
parser.add_argument('-l', '--log', type=str, required=False, help="log file")
args = parser.parse_args()
test_ratio=0.3
if args.test:
    test_ratio=float(args.valid)
validation_ratio=0.2
if args.valid:
    validation_ratio=float(args.valid)
learning_rate = 0.0005
if args.rate:
    learning_rate=float(args.rate)
training_epochs = 20
if args.epochs:
    training_epochs=int(args.epochs)
batch_size = 256
if args.batch_size:
    batch_size=int(args.batch_size)
unit_1=512
unit_2=512
if args.dense1:
    unit_1=int(args.dense1)
if args.dense2:
    unit_2=int(args.dense2)
use_log=False
log_file=""
if args.log:
    use_log=True
    log_file=args.log

Xall=np.loadtxt(args.trnx)
Yall=np.loadtxt(args.trny)
Xall,Yall=shuffle(Xall,Yall)
test_size = int(test_ratio * Xall.shape[0])
validation_size = int(validation_ratio * (Xall.shape[0]-test_size))
Xtrn=Xall[(validation_size+test_size):]
Ytrn=Yall[(validation_size+test_size):]
Xval=Xall[test_size:(validation_size+test_size)]
Yval=Yall[test_size:(validation_size+test_size)]
Xtst=Xall[:test_size]
Ytst=Yall[:test_size]
num_classes=2
model=Sequential()
model.add(Dense(unit_1,activation='relu'))
model.add(Dropout(0.25))
model.add(Dense(unit_2,activation='relu'))
model.add(Dropout(0.25))
model.add(Dense(num_classes, activation='softmax'))
model.compile(optimizer=tf.train.AdamOptimizer(learning_rate),
              loss='categorical_crossentropy', metrics=['accuracy'])
model.fit(Xtrn, Ytrn, validation_data=(Xval,Yval), epochs=training_epochs, batch_size=batch_size)
Ypred=model.predict(Xtst).ravel()
fpr, tpr, threshold = roc_curve(Ytst.ravel(), Ypred)
auc_dnn = auc(fpr,tpr)
print("AUC dnn")
print(auc_dnn)
grs=np.sum(Xtst,axis=1)
Ygrs=Ytst[:,0]
fpr1, tpr1, threshold1 = roc_curve(Ygrs, grs)
auc_grs = auc(fpr1,tpr1)
print("AUC grs")
print(auc_grs)
if use_log:
    scores=model.evaluate(Xtst,Ytst)
    with open(log_file,"w") as of:
        of.write("Loss: "+str(scores[0])+"\nAccuracy: "+str(scores[1])+"\n")
        of.write("AUC dnn: "+str(auc_dnn)+"\n")
        of.write("AUC grs: "+str(auc_grs)+"\n")
   

