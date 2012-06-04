import java.lang { System { getProperty } }
import ceylon.fs.internal { newPath=path, allRootPaths=rootPaths }

doc "Represents a path in a hierarchical filesystem. A 
     path is a sequence of path elements. A path may be 
     an absolute path that begins at the root of the 
     filesystem, or a relative path."
shared abstract class Path() satisfies Comparable<Path> {
    
    doc "This path, after removing the last path element."
    shared formal Path parent;
    
    doc "This path, after appending the given path 
         element."
    shared formal Path childPath(String|Path subpath);
    
    doc "This path, after removing the last path element,
         and then appending the given path element."
    shared formal Path siblingPath(String|Path subpath);
    
    doc "This path, converted into an absolute path. If 
         this path is already absolute, return this path.
         Otherwise, if this path is a relative path, 
         resolve it against the filesystem's default 
         directory."
    shared formal Path absolutePath;
    
    doc "This path, simplified to a canonical form."
    shared formal Path normalizedPath;
    
    doc "This path, converted into a path relative to 
         the given path."
    shared formal Path relativePath(String|Path path);
    
    doc "The path elements of this path, as paths 
         consisting of a single path element."
    shared formal Path[] elementPaths;
    
    doc "The path elements of this path, as strings."
    shared formal String[] elements;
    
    doc "Determine if this is an absolute path."
    shared formal Boolean absolute;
    
    doc "Obtain a `Resource` representing the file or
         directory located at this path."
    shared formal Resource resource;
    
    doc "Determin if this path is a parent of the
         given path."
    shared formal Boolean parentOf(Path path);
    
    doc "Determine if this path is a child of the
         given path."
    shared formal Boolean childOf(Path path);
    
    doc "Walk the tree of directories rooted at this 
         path and visit files contained in this
         directory tree."
    shared formal void visit(Visitor visitor);
    
    doc "The separator character used by this path."
    shared formal String separator;
    
    doc "This path, expressed as a string."
    shared actual formal String string;
    
}

doc "Obtain a `Path` given the string representation
     of a path."
shared Path path(String pathString) = newPath;

doc "The `Path` representing the user home directory."
shared Path home = path(getProperty("user.home"));

doc "The `Path`s representing the root directories of
     the filesystem."
shared Path[] rootPaths = allRootPaths;

doc "A file visitor."
shared class Visitor() {
    
    doc "Called before visiting files and subdirectories
         of the given directory. If this method returns 
         `false`, the files and subdirecties of the given 
         directory will not be visited."
    shared default Boolean beforeDirectory(Directory dir) { return true; }
    
    doc "Called after visiting files and subdirectories
         of the given directory."
    shared default void afterDirectory(Directory dir) {}
    
    doc "Visit a file."
    shared default void file(File file) {}
    
    doc "Evaluates to `true` to indicate that no more
         files or directories should be visited."
    shared default Boolean terminated { return false; }
    
}