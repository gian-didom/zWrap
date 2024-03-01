function fullpath = resolvePath(filename)
  file=java.io.File(filename);
  if file.isAbsolute()
      fullpath = filename;
  else
      fullpath = char(file.getCanonicalPath());
  end
  if file.exists()
      return
  else
      error('resolvePath:CannotResolve', 'Does not exist or failed to resolve absolute path for %s.', filename);
  end