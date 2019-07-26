/*
 * Exchange Web Services Managed API
 *
 * Copyright (c) Microsoft Corporation
 * All rights reserved.
 *
 * MIT License
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
 * to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */







    /// <summary>
    /// Represents the results of a People Index search operation.
    /// </summary>
 sealed class PeopleQueryMode
    {
        /// <summary>
        /// This mode will attempt to find a good match as quickly as possible
        /// among the various potential sources. This is a good setting to use
        /// by default.
        /// </summary>
 static PeopleQueryMode Auto
        {
            get { return autoInstance; }
        }

        /// <summary>
        /// The Source String for Auto
        /// </summary>
        /* private */ const String AutoSourceString = "Auto";

        /// <summary>
        /// The field for the auto mode
        /// </summary>
        /* private */ static PeopleQueryMode autoInstance = new PeopleQueryMode();

        /// <summary>
        /// The sources used for this mode.
        /// </summary>
        HashSet<string> Sources;

        /// <summary>
        /// Creates a new instance of the <see cref="PeopleQueryMode"/> class.
        /// </summary>
        /* private */ PeopleQueryMode()
        {
            this.Sources = new HashSet<string>(new string[] { AutoSourceString });
        }

        /// <summary>
        /// Creates a new instance of the <see cref="PeopleQueryMode"/> class.
        /// </summary>
        /// <param name="sources">The sources to use. See <see cref="PeopleQuerySource"/> for sources</param>
 PeopleQueryMode(Iterable<string> sources)
        {
            EwsUtilities.ValidateParam(sources, "sources");

            this.Sources = new HashSet<string>(sources);

            // The call should either be auto or a list of real sources, so disallow this constructor from passing Auto
            if (this.Sources.Contains(AutoSourceString))
            {
                throw new ArgumentError("Cannot pass 'Auto' as a source");
            }
        }
    }
