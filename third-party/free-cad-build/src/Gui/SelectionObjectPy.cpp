
// This file is generated by src/Tools/generateTemaplates/templateClassPyExport.py out of the .XML file
// Every change you make here get lost at the next full rebuild!
// This File is normaly build as an include in SelectionObjectPyImp.cpp! Its not intended to be in a project!

#include <boost/filesystem/path.hpp>
#include <boost/filesystem/operations.hpp>
#include <boost/filesystem/exception.hpp>
#include <Base/PyObjectBase.h>
#include <Base/Console.h>
#include <Base/Exception.h>
#include <CXX/Objects.hxx>

#define new DEBUG_CLIENTBLOCK

using Base::streq;
using namespace Gui;

/// Type structure of SelectionObjectPy
PyTypeObject SelectionObjectPy::Type = {
    PyObject_HEAD_INIT(&PyType_Type)
    0,                                                /*ob_size*/
    "Gui.SelectionObject",     /*tp_name*/
    sizeof(SelectionObjectPy),                       /*tp_basicsize*/
    0,                                                /*tp_itemsize*/
    /* methods */
    PyDestructor,                                     /*tp_dealloc*/
    0,                                                /*tp_print*/
    __getattr,                                        /*tp_getattr*/
    __setattr,                                        /*tp_setattr*/
    0,                                                /*tp_compare*/
    __repr,                                           /*tp_repr*/
    0,                                                /*tp_as_number*/
    0,                                                /*tp_as_sequence*/
    0,                                                /*tp_as_mapping*/
    0,                                                /*tp_hash*/
    0,                                                /*tp_call */
    0,                                                /*tp_str  */
    0,                                                /*tp_getattro*/
    0,                                                /*tp_setattro*/
    /* --- Functions to access object as input/output buffer ---------*/
    0,                                                /* tp_as_buffer */
    /* --- Flags to define presence of optional/expanded features */
    Py_TPFLAGS_BASETYPE|Py_TPFLAGS_HAVE_CLASS,        /*tp_flags */
    "This class represents selections made by the user. It holds information about the object, document and sub-element of the selection.",           /*tp_doc */
    0,                                                /*tp_traverse */
    0,                                                /*tp_clear */
    0,                                                /*tp_richcompare */
    0,                                                /*tp_weaklistoffset */
    0,                                                /*tp_iter */
    0,                                                /*tp_iternext */
    Gui::SelectionObjectPy::Methods,                     /*tp_methods */
    0,                                                /*tp_members */
    Gui::SelectionObjectPy::GetterSetter,                     /*tp_getset */
    &Base::BaseClassPy::Type,                        /*tp_base */
    0,                                                /*tp_dict */
    0,                                                /*tp_descr_get */
    0,                                                /*tp_descr_set */
    0,                                                /*tp_dictoffset */
    __PyInit,                                         /*tp_init */
    0,                                                /*tp_alloc */
    Gui::SelectionObjectPy::PyMake,/*tp_new */
    0,                                                /*tp_free   Low-level free-memory routine */
    0,                                                /*tp_is_gc  For PyObject_IS_GC */
    0,                                                /*tp_bases */
    0,                                                /*tp_mro    method resolution order */
    0,                                                /*tp_cache */
    0,                                                /*tp_subclasses */
    0,                                                /*tp_weaklist */
    0                                                 /*tp_del */
};

/// Methods structure of SelectionObjectPy
PyMethodDef SelectionObjectPy::Methods[] = {
    {"remove",
        (PyCFunction) staticCallback_remove,
        METH_VARARGS,
        "Remove this selection item from the selection. This object becomes invalid."
    },
    {"isA",
        (PyCFunction) staticCallback_isA,
        METH_VARARGS,
        "Test for a certain father class."
    },
    {NULL, NULL, 0, NULL}		/* Sentinel */
};



/// Attribute structure of SelectionObjectPy
PyGetSetDef SelectionObjectPy::GetterSetter[] = {
    {"ObjectName",
        (getter) staticCallback_getObjectName,
        (setter) staticCallback_setObjectName, 
        "Name of the selected object",
        NULL
    },
    {"SubElementNames",
        (getter) staticCallback_getSubElementNames,
        (setter) staticCallback_setSubElementNames, 
        "Name of the selected sub-element if any",
        NULL
    },
    {"FullName",
        (getter) staticCallback_getFullName,
        (setter) staticCallback_setFullName, 
        "Name of the selected object",
        NULL
    },
    {"DocumentName",
        (getter) staticCallback_getDocumentName,
        (setter) staticCallback_setDocumentName, 
        "Name of the document of the selected object",
        NULL
    },
    {"Document",
        (getter) staticCallback_getDocument,
        (setter) staticCallback_setDocument, 
        "Selected document",
        NULL
    },
    {"Object",
        (getter) staticCallback_getObject,
        (setter) staticCallback_setObject, 
        "Selected object",
        NULL
    },
    {"SubObjects",
        (getter) staticCallback_getSubObjects,
        (setter) staticCallback_setSubObjects, 
        "Selected sub-element, if any",
        NULL
    },
    {"HasSubObjects",
        (getter) staticCallback_getHasSubObjects,
        (setter) staticCallback_setHasSubObjects, 
        "Selected sub-element, if any",
        NULL
    },
    {NULL, NULL, NULL, NULL, NULL}		/* Sentinel */
};

// remove() callback and implementer
// PyObject*  SelectionObjectPy::remove(PyObject *args){};
// has to be implemented in SelectionObjectPyImp.cpp
PyObject * SelectionObjectPy::staticCallback_remove (PyObject *self, PyObject *args)
{
    // test if twin object not allready deleted
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return NULL;
    }

    // test if object is set Const
    if (((PyObjectBase*) self)->isConst()){
        PyErr_SetString(PyExc_ReferenceError, "This object is immutable, you can not set any attribute or call a non const method");
        return NULL;
    }

    try { // catches all exceptions coming up from c++ and generate a python exception
        PyObject* ret = ((SelectionObjectPy*)self)->remove(args);
        if (ret != 0)
            ((SelectionObjectPy*)self)->startNotify();
        return ret;
    }
    catch(const Base::Exception& e) // catch the FreeCAD exceptions
    {
        std::string str;
        str += "FreeCAD exception thrown (";
        str += e.what();
        str += ")";
        e.ReportException();
        PyErr_SetString(PyExc_Exception,str.c_str());
        return NULL;
    }
    catch(const boost::filesystem::filesystem_error& e) // catch boost filesystem exception
    {
        std::string str;
        str += "File system exception thrown (";
        //str += e.who();
        //str += ", ";
        str += e.what();
        str += ")\n";
        Base::Console().Error(str.c_str());
        PyErr_SetString(PyExc_Exception,str.c_str());
        return NULL;
    }
    catch(const Py::Exception&)
    {
        // The exception text is already set
        return NULL;
    }
    catch(const char* e) // catch simple string exceptions
    {
        Base::Console().Error(e);
        PyErr_SetString(PyExc_Exception,e);
        return NULL;
    }
    // in debug not all exceptions will be catched to get the attention of the developer!
#ifndef DONT_CATCH_CXX_EXCEPTIONS 
    catch(const std::exception& e) // catch other c++ exceptions
    {
        std::string str;
        str += "FC++ exception thrown (";
        str += e.what();
        str += ")";
        Base::Console().Error(str.c_str());
        PyErr_SetString(PyExc_Exception,str.c_str());
        return NULL;
    }
    catch(...)  // catch the rest!
    {
        PyErr_SetString(PyExc_Exception,"Unknown C++ exception");
        return NULL;
    }
#endif
}

// isA() callback and implementer
// PyObject*  SelectionObjectPy::isA(PyObject *args){};
// has to be implemented in SelectionObjectPyImp.cpp
PyObject * SelectionObjectPy::staticCallback_isA (PyObject *self, PyObject *args)
{
    // test if twin object not allready deleted
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return NULL;
    }

    // test if object is set Const
    if (((PyObjectBase*) self)->isConst()){
        PyErr_SetString(PyExc_ReferenceError, "This object is immutable, you can not set any attribute or call a non const method");
        return NULL;
    }

    try { // catches all exceptions coming up from c++ and generate a python exception
        PyObject* ret = ((SelectionObjectPy*)self)->isA(args);
        if (ret != 0)
            ((SelectionObjectPy*)self)->startNotify();
        return ret;
    }
    catch(const Base::Exception& e) // catch the FreeCAD exceptions
    {
        std::string str;
        str += "FreeCAD exception thrown (";
        str += e.what();
        str += ")";
        e.ReportException();
        PyErr_SetString(PyExc_Exception,str.c_str());
        return NULL;
    }
    catch(const boost::filesystem::filesystem_error& e) // catch boost filesystem exception
    {
        std::string str;
        str += "File system exception thrown (";
        //str += e.who();
        //str += ", ";
        str += e.what();
        str += ")\n";
        Base::Console().Error(str.c_str());
        PyErr_SetString(PyExc_Exception,str.c_str());
        return NULL;
    }
    catch(const Py::Exception&)
    {
        // The exception text is already set
        return NULL;
    }
    catch(const char* e) // catch simple string exceptions
    {
        Base::Console().Error(e);
        PyErr_SetString(PyExc_Exception,e);
        return NULL;
    }
    // in debug not all exceptions will be catched to get the attention of the developer!
#ifndef DONT_CATCH_CXX_EXCEPTIONS 
    catch(const std::exception& e) // catch other c++ exceptions
    {
        std::string str;
        str += "FC++ exception thrown (";
        str += e.what();
        str += ")";
        Base::Console().Error(str.c_str());
        PyErr_SetString(PyExc_Exception,str.c_str());
        return NULL;
    }
    catch(...)  // catch the rest!
    {
        PyErr_SetString(PyExc_Exception,"Unknown C++ exception");
        return NULL;
    }
#endif
}

// ObjectName() callback and implementer
// PyObject*  SelectionObjectPy::ObjectName(PyObject *args){};
// has to be implemented in SelectionObjectPyImp.cpp
PyObject * SelectionObjectPy::staticCallback_getObjectName (PyObject *self, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return NULL;
    }

    try {
        return Py::new_reference_to(((SelectionObjectPy*)self)->getObjectName());
    } catch (const Py::Exception&) {
        // The exception text is already set
        return NULL;
    } catch (...) {
        PyErr_SetString(PyExc_Exception, "Unknown exception while reading attribute 'ObjectName' of object 'SelectionObject'");
        return NULL;
    }
}

int SelectionObjectPy::staticCallback_setObjectName (PyObject *self, PyObject * /*value*/, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return -1;
    }

    PyErr_SetString(PyExc_AttributeError, "Attribute 'ObjectName' of object 'SelectionObject' is read-only");
    return -1;
}

// SubElementNames() callback and implementer
// PyObject*  SelectionObjectPy::SubElementNames(PyObject *args){};
// has to be implemented in SelectionObjectPyImp.cpp
PyObject * SelectionObjectPy::staticCallback_getSubElementNames (PyObject *self, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return NULL;
    }

    try {
        return Py::new_reference_to(((SelectionObjectPy*)self)->getSubElementNames());
    } catch (const Py::Exception&) {
        // The exception text is already set
        return NULL;
    } catch (...) {
        PyErr_SetString(PyExc_Exception, "Unknown exception while reading attribute 'SubElementNames' of object 'SelectionObject'");
        return NULL;
    }
}

int SelectionObjectPy::staticCallback_setSubElementNames (PyObject *self, PyObject * /*value*/, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return -1;
    }

    PyErr_SetString(PyExc_AttributeError, "Attribute 'SubElementNames' of object 'SelectionObject' is read-only");
    return -1;
}

// FullName() callback and implementer
// PyObject*  SelectionObjectPy::FullName(PyObject *args){};
// has to be implemented in SelectionObjectPyImp.cpp
PyObject * SelectionObjectPy::staticCallback_getFullName (PyObject *self, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return NULL;
    }

    try {
        return Py::new_reference_to(((SelectionObjectPy*)self)->getFullName());
    } catch (const Py::Exception&) {
        // The exception text is already set
        return NULL;
    } catch (...) {
        PyErr_SetString(PyExc_Exception, "Unknown exception while reading attribute 'FullName' of object 'SelectionObject'");
        return NULL;
    }
}

int SelectionObjectPy::staticCallback_setFullName (PyObject *self, PyObject * /*value*/, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return -1;
    }

    PyErr_SetString(PyExc_AttributeError, "Attribute 'FullName' of object 'SelectionObject' is read-only");
    return -1;
}

// DocumentName() callback and implementer
// PyObject*  SelectionObjectPy::DocumentName(PyObject *args){};
// has to be implemented in SelectionObjectPyImp.cpp
PyObject * SelectionObjectPy::staticCallback_getDocumentName (PyObject *self, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return NULL;
    }

    try {
        return Py::new_reference_to(((SelectionObjectPy*)self)->getDocumentName());
    } catch (const Py::Exception&) {
        // The exception text is already set
        return NULL;
    } catch (...) {
        PyErr_SetString(PyExc_Exception, "Unknown exception while reading attribute 'DocumentName' of object 'SelectionObject'");
        return NULL;
    }
}

int SelectionObjectPy::staticCallback_setDocumentName (PyObject *self, PyObject * /*value*/, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return -1;
    }

    PyErr_SetString(PyExc_AttributeError, "Attribute 'DocumentName' of object 'SelectionObject' is read-only");
    return -1;
}

// Document() callback and implementer
// PyObject*  SelectionObjectPy::Document(PyObject *args){};
// has to be implemented in SelectionObjectPyImp.cpp
PyObject * SelectionObjectPy::staticCallback_getDocument (PyObject *self, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return NULL;
    }

    try {
        return Py::new_reference_to(((SelectionObjectPy*)self)->getDocument());
    } catch (const Py::Exception&) {
        // The exception text is already set
        return NULL;
    } catch (...) {
        PyErr_SetString(PyExc_Exception, "Unknown exception while reading attribute 'Document' of object 'SelectionObject'");
        return NULL;
    }
}

int SelectionObjectPy::staticCallback_setDocument (PyObject *self, PyObject * /*value*/, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return -1;
    }

    PyErr_SetString(PyExc_AttributeError, "Attribute 'Document' of object 'SelectionObject' is read-only");
    return -1;
}

// Object() callback and implementer
// PyObject*  SelectionObjectPy::Object(PyObject *args){};
// has to be implemented in SelectionObjectPyImp.cpp
PyObject * SelectionObjectPy::staticCallback_getObject (PyObject *self, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return NULL;
    }

    try {
        return Py::new_reference_to(((SelectionObjectPy*)self)->getObject());
    } catch (const Py::Exception&) {
        // The exception text is already set
        return NULL;
    } catch (...) {
        PyErr_SetString(PyExc_Exception, "Unknown exception while reading attribute 'Object' of object 'SelectionObject'");
        return NULL;
    }
}

int SelectionObjectPy::staticCallback_setObject (PyObject *self, PyObject * /*value*/, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return -1;
    }

    PyErr_SetString(PyExc_AttributeError, "Attribute 'Object' of object 'SelectionObject' is read-only");
    return -1;
}

// SubObjects() callback and implementer
// PyObject*  SelectionObjectPy::SubObjects(PyObject *args){};
// has to be implemented in SelectionObjectPyImp.cpp
PyObject * SelectionObjectPy::staticCallback_getSubObjects (PyObject *self, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return NULL;
    }

    try {
        return Py::new_reference_to(((SelectionObjectPy*)self)->getSubObjects());
    } catch (const Py::Exception&) {
        // The exception text is already set
        return NULL;
    } catch (...) {
        PyErr_SetString(PyExc_Exception, "Unknown exception while reading attribute 'SubObjects' of object 'SelectionObject'");
        return NULL;
    }
}

int SelectionObjectPy::staticCallback_setSubObjects (PyObject *self, PyObject * /*value*/, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return -1;
    }

    PyErr_SetString(PyExc_AttributeError, "Attribute 'SubObjects' of object 'SelectionObject' is read-only");
    return -1;
}

// HasSubObjects() callback and implementer
// PyObject*  SelectionObjectPy::HasSubObjects(PyObject *args){};
// has to be implemented in SelectionObjectPyImp.cpp
PyObject * SelectionObjectPy::staticCallback_getHasSubObjects (PyObject *self, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return NULL;
    }

    try {
        return Py::new_reference_to(((SelectionObjectPy*)self)->getHasSubObjects());
    } catch (const Py::Exception&) {
        // The exception text is already set
        return NULL;
    } catch (...) {
        PyErr_SetString(PyExc_Exception, "Unknown exception while reading attribute 'HasSubObjects' of object 'SelectionObject'");
        return NULL;
    }
}

int SelectionObjectPy::staticCallback_setHasSubObjects (PyObject *self, PyObject * /*value*/, void * /*closure*/)
{
    if (!((PyObjectBase*) self)->isValid()){
        PyErr_SetString(PyExc_ReferenceError, "This object is already deleted most likely through closing a document. This reference is no longer valid!");
        return -1;
    }

    PyErr_SetString(PyExc_AttributeError, "Attribute 'HasSubObjects' of object 'SelectionObject' is read-only");
    return -1;
}



//--------------------------------------------------------------------------
// Parents structure
//--------------------------------------------------------------------------
PyParentObject SelectionObjectPy::Parents[] = { PARENTSGuiSelectionObjectPy };

//--------------------------------------------------------------------------
// Constructor
//--------------------------------------------------------------------------
SelectionObjectPy::SelectionObjectPy(SelectionObject *pcObject, PyTypeObject *T)
    : BaseClassPy(reinterpret_cast<BaseClassPy::PointerType>(pcObject), T)
{
}

PyObject *SelectionObjectPy::PyMake(struct _typeobject *, PyObject *, PyObject *)  // Python wrapper
{
    // never create such objects with the constructor
    PyErr_SetString(PyExc_RuntimeError, "You cannot create directly an instance of 'SelectionObjectPy'.");
 
    return 0;
}

int SelectionObjectPy::PyInit(PyObject* /*args*/, PyObject* /*kwd*/)
{
    return 0;
}

//--------------------------------------------------------------------------
// destructor
//--------------------------------------------------------------------------
SelectionObjectPy::~SelectionObjectPy()                                // Everything handled in parent
{
    // delete the handled object when the PyObject dies
    SelectionObjectPy::PointerType ptr = reinterpret_cast<SelectionObjectPy::PointerType>(_pcTwinPointer);
    delete ptr;
}

//--------------------------------------------------------------------------
// SelectionObjectPy representation
//--------------------------------------------------------------------------
PyObject *SelectionObjectPy::_repr(void)
{
    return Py_BuildValue("s", representation().c_str());
}

//--------------------------------------------------------------------------
// SelectionObjectPy Attributes
//--------------------------------------------------------------------------
PyObject *SelectionObjectPy::_getattr(char *attr)				// __getattr__ function: note only need to handle new state
{
    try {
        // getter method for special Attributes (e.g. dynamic ones)
        PyObject *r = getCustomAttributes(attr);
        if(r) return r;
    }
#ifndef DONT_CATCH_CXX_EXCEPTIONS 
    catch(const Base::Exception& e) // catch the FreeCAD exceptions
    {
        std::string str;
        str += "FreeCAD exception thrown (";
        str += e.what();
        str += ")";
        e.ReportException();
        PyErr_SetString(PyExc_Exception,str.c_str());
        return NULL;
    }
    catch(const std::exception& e) // catch other c++ exceptions
    {
        std::string str;
        str += "FC++ exception thrown (";
        str += e.what();
        str += ")";
        Base::Console().Error(str.c_str());
        PyErr_SetString(PyExc_Exception,str.c_str());
        return NULL;
    }
    catch(const Py::Exception&)
    {
        // The exception text is already set
        return NULL;
    }
    catch(...)  // catch the rest!
    {
        PyErr_SetString(PyExc_Exception,"Unknown C++ exception");
        return NULL;
    }
#else  // DONT_CATCH_CXX_EXCEPTIONS  
    catch(const Base::Exception& e) // catch the FreeCAD exceptions
    {
        std::string str;
        str += "FreeCAD exception thrown (";
        str += e.what();
        str += ")";
        e.ReportException();
        PyErr_SetString(PyExc_Exception,str.c_str());
        return NULL;
    }
    catch(const Py::Exception&)
    {
        // The exception text is already set
        return NULL;
    }
#endif  // DONT_CATCH_CXX_EXCEPTIONS

    PyObject *rvalue = Py_FindMethod(Methods, this, attr);
    if (rvalue == NULL)
    {
        PyErr_Clear();
        return BaseClassPy::_getattr(attr);
    }
    else
    {
        return rvalue;
    }
}

int SelectionObjectPy::_setattr(char *attr, PyObject *value) 	// __setattr__ function: note only need to handle new state
{
    try {
        // setter for  special Attributes (e.g. dynamic ones)
        int r = setCustomAttributes(attr, value);
        if(r==1) return 0;
    }
#ifndef DONT_CATCH_CXX_EXCEPTIONS 
    catch(const Base::Exception& e) // catch the FreeCAD exceptions
    {
        std::string str;
        str += "FreeCAD exception thrown (";
        str += e.what();
        str += ")";
        e.ReportException();
        PyErr_SetString(PyExc_Exception,str.c_str());
        return -1;
    }
    catch(const std::exception& e) // catch other c++ exceptions
    {
        std::string str;
        str += "FC++ exception thrown (";
        str += e.what();
        str += ")";
        Base::Console().Error(str.c_str());
        PyErr_SetString(PyExc_Exception,str.c_str());
        return -1;
    }
    catch(const Py::Exception&)
    {
        // The exception text is already set
        return -1;
    }
    catch(...)  // catch the rest!
    {
        PyErr_SetString(PyExc_Exception,"Unknown C++ exception");
        return -1;
    }
#else  // DONT_CATCH_CXX_EXCEPTIONS  
    catch(const Base::Exception& e) // catch the FreeCAD exceptions
    {
        std::string str;
        str += "FreeCAD exception thrown (";
        str += e.what();
        str += ")";
        e.ReportException();
        PyErr_SetString(PyExc_Exception,str.c_str());
        return -1;
    }
    catch(const Py::Exception&)
    {
        // The exception text is already set
        return -1;
    }
#endif  // DONT_CATCH_CXX_EXCEPTIONS

    return BaseClassPy::_setattr(attr, value);
}

SelectionObject *SelectionObjectPy::getSelectionObjectPtr(void) const
{
    return static_cast<SelectionObject *>(_pcTwinPointer);
}

#if 0
/* From here on come the methods you have to implement, but NOT in this module. Implement in SelectionObjectPyImp.cpp! This prototypes 
 * are just for convenience when you add a new method.
 */


// returns a string which represents the object e.g. when printed in python
std::string SelectionObjectPy::representation(void) const
{
    return std::string("<SelectionObject object>");
}

PyObject* SelectionObjectPy::remove(PyObject *args)
{
    PyErr_SetString(PyExc_NotImplementedError, "Not yet implemented");
    return 0;
}

PyObject* SelectionObjectPy::isA(PyObject *args)
{
    PyErr_SetString(PyExc_NotImplementedError, "Not yet implemented");
    return 0;
}



Py::String SelectionObjectPy::getObjectName(void) const
{
    //return Py::String();
    throw Py::AttributeError("Not yet implemented");
}

Py::List SelectionObjectPy::getSubElementNames(void) const
{
    //return Py::List();
    throw Py::AttributeError("Not yet implemented");
}

Py::String SelectionObjectPy::getFullName(void) const
{
    //return Py::String();
    throw Py::AttributeError("Not yet implemented");
}

Py::String SelectionObjectPy::getDocumentName(void) const
{
    //return Py::String();
    throw Py::AttributeError("Not yet implemented");
}

Py::Object SelectionObjectPy::getDocument(void) const
{
    //return Py::Object();
    throw Py::AttributeError("Not yet implemented");
}

Py::Object SelectionObjectPy::getObject(void) const
{
    //return Py::Object();
    throw Py::AttributeError("Not yet implemented");
}

Py::List SelectionObjectPy::getSubObjects(void) const
{
    //return Py::List();
    throw Py::AttributeError("Not yet implemented");
}

Py::Boolean SelectionObjectPy::getHasSubObjects(void) const
{
    //return Py::Boolean();
    throw Py::AttributeError("Not yet implemented");
}

PyObject *SelectionObjectPy::getCustomAttributes(const char* attr) const
{
    return 0;
}

int SelectionObjectPy::setCustomAttributes(const char* attr, PyObject *obj)
{
    return 0; 
}
#endif



