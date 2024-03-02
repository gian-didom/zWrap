class coderBoundedMatrix:public coderMatrix
{public:
public:
Property SizeType;
public:
Property DataTypePadding;
public:
         function  coderBoundedMatrix(in dataObj,in  sizeObj);
 function  checkFunction(in obj,in  dataRepr);
 function  generateDecoderFunction(in obj,in  accessName,in  nestLevel);
 function  generateMATLABFunction(in obj,in  accessName,in  nestLevel);
 function  getTemplate(in obj);
 function  getTotalSize(in obj);
 function  getTotalSizePadded(in obj);
};
