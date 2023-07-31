function st = generateRandomString()
 symbols = ['a':'z' 'A':'Z'];
 stLength = 10;
 nums = randi(numel(symbols),[1 stLength]);
 st = symbols (nums);

end