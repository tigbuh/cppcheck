/*
 * Cppcheck - A tool for static C/C++ code analysis
 * Copyright (C) 2007-2010 Daniel Marjamäki and Cppcheck team.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef CPPCHECK_H
#define CPPCHECK_H

#include "settings.h"
#include "errorlogger.h"
#include "checkunusedfunctions.h"

#include <string>
#include <list>
#include <sstream>
#include <vector>
#include <map>

/// @addtogroup Core
/// @{

/**
 * @brief This is the base class which will use other classes to do
 * static code analysis for C and C++ code to find possible
 * errors or places that could be improved.
 * Usage: See check() for more info.
 */
class CppCheck : public ErrorLogger
{
public:
    /**
     * @brief Constructor.
     */
    CppCheck(ErrorLogger &errorLogger);

    /**
     * @brief Destructor.
     */
    virtual ~CppCheck();

    /**
     * @brief This starts the actual checking. Note that you must call
     * parseFromArgs() or settings() and addFile() before calling this.
     * @return amount of errors found or 0 if none were found.
     */
    unsigned int check();

    /**
     * @brief Adjust the settings before doing the check. E.g. show only
     * actual bugs or also coding style issues.
     *
     * @param settings New settings which will overwrite the old.
     */
    void settings(const Settings &settings);

    /**
     * @brief Get copy of current settings.
     * @return a copy of current settings
     */
    Settings settings() const;

    /**
     * @brief Add new file to be checked.
     *
     * @param path Relative or absolute path to the file to be checked,
     * e.g. "cppcheck.cpp". Note that only source files (.c, .cc or .cpp)
     * should be added to the list. Include files are gathered automatically.
     * You can also give path, e.g. "src/" which will be scanned for source
     * files recursively.
     */
    void addFile(const std::string &path);

    /**
     * @brief Add new unreal file to be checked.
     *
     * @param path File name (used for error reporting).
     * @param content If the file would be a real file, this should be
     * the content of the file.
     */
    void addFile(const std::string &path, const std::string &content);

    /**
     * @brief Remove all files added with addFile() and parseFromArgs().
     */
    void clearFiles();

    /**
     * @brief Returns current version number as a string.
     * @return version, e.g. "1.38"
     */
    static const char * version();

    const std::vector<std::string> &filenames() const;

    virtual void reportStatus(unsigned int index, unsigned int max);

    /**
     * @brief Terminate checking. The checking will be terminated as soon as possible.
     */
    void terminate()
    {
        _settings.terminate();
    }

    /**
     * @brief Call all "getErrorMessages" in all registered Check classes.
     * Also print out xml header and footer.
     */
    void getErrorMessages();

    /**
     * @brief Analyse file - It's public so unit tests can be written
     */
    void analyseFile(std::istream &f, const std::string &filename);

private:
    /** @brief Check file */
    void checkFile(const std::string &code, const char FileName[]);

    /**
     * @brief Errors and warnings are directed here.
     *
     * @param msg Errors messages are normally in format
     * "[filepath:line number] Message", e.g.
     * "[main.cpp:4] Uninitialized member variable"
     */
    virtual void reportErr(const ErrorLogger::ErrorMessage &msg);

    /**
     * @brief Information about progress is directed here.
     *
     * @param outmsg Message to show, e.g. "Checking main.cpp..."
     */
    virtual void reportOut(const std::string &outmsg);

    unsigned int exitcode;
    std::list<std::string> _errorList;
    std::ostringstream _errout;
    Settings _settings;
    std::vector<std::string> _filenames;

    void reportProgress(const std::string &filename, const char stage[], const unsigned int value);

    /** @brief Key is file name, and value is the content of the file */
    std::map<std::string, std::string> _fileContents;

    CheckUnusedFunctions _checkUnusedFunctions;
    ErrorLogger &_errorLogger;

    /** @brief Current preprocessor configuration */
    std::string     cfg;
};

/// @}

#endif // CPPCHECK_H
