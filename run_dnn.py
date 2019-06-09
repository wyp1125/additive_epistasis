import tensorflow as tf
import keras
from keras.models import Sequential
from keras.layers import Bidirectional, LSTM
from keras.layers import Dense, Dropout, Flatten
from keras.layers import Conv2D, MaxPooling2D
import numpy as np
from sklearn.utils import shuffle
import argparse
parser = argparse.ArgumentParser(description='Process input files and parameters.')
parser.add_argument('-x', '--trnx', type=str, required=True, help="training features")
parser.add_argument('-y', '--trny', type=str, required=True, help="training outcomes")
parser.add_argument('-v', '--valid', type=str, required=False, help="validation ratio")
parser.add_argument('-r', '--rate', type=float, required=False, help="learning rate")
parser.add_argument('-c', '--epochs', type=int, required=False, help="number of epochs")
parser.add_argument('-b', '--batch_size', type=int, required=False, help="batch size")
parser.add_argument('-l', '--log', type=str, required=False, help="log file")
args = parser.parse_args()
validation_ratio=0.2
if args.valid:
    validation_ratio=args.valid
learning_rate = 0.001
if args.rate:
    learning_rate=args.rate
training_epochs = 10
if args.epochs:
    training_epochs=args.epochs
batch_size = 256
if args.batch_size:
    batch_size=args.batch_size
use_tb=False
log_dir=""
if args.log:
    use_tb=True
    log_dir=args.log

Xall=np.loadtxt(args.trnx)
Yall=np.loadtxt(args.trny)
Xall,Yall=shuffle(Xall,Yall)
#print(Xall.shape)
validation_size = int(validation_ratio * Xall.shape[0])
#print(validation_size)
Xtrn=Xall[validation_size:]
Ytrn=Yall[validation_size:]
Xtst=Xall[:validation_size]
Ytst=Yall[:validation_size]
#print(Xtrn.shape)
#print(Ytrn.shape)
#print(Xtst.shape)
#print(Ytst.shape)
num_classes=2
model=Sequential()
model.add(Dense(512,activation='relu'))
model.add(Dropout(0.25))
model.add(Dense(512,activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(num_classes, activation='softmax'))
model.compile(optimizer=tf.train.AdamOptimizer(learning_rate),
              loss='categorical_crossentropy', metrics=['accuracy'])
model.fit(Xtrn, Ytrn, validation_data=(Xtst,Ytst), epochs=training_epochs, batch_size=batch_size)
