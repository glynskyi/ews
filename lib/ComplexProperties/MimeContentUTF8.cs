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
    /// Represents the MIME content of an item.
    /// </summary>
 class MimeContentUTF8 extends MimeContentBase
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="MimeContentUTF8"/> class.
        /// </summary>
 MimeContentUTF8()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="MimeContentUTF8"/> class.
        /// </summary>
        /// <param name="content">The content.</param>
 MimeContentUTF8(Uint8List content)
        {
            this.CharacterSet = Encoding.UTF8.BodyName;
            this.Content = content;
        }

        #region Object method overrides
        /// <summary>
        /// Returns a <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
        /// </summary>
        /// <returns>
        /// A <see cref="T:System.String"/> that represents the current <see cref="T:System.Object"/>.
        /// </returns>
@override
 String toString()
        {
            if (this.Content == null)
            {
                return "";
            }
            else
            {
                try
                {

                    // return the Base64 representation of the content.
                    // Note: Encoding.GetString can throw DecoderFallbackException which is a subclass
                    // of ArgumentError.
                    // it should always be UTF8 encoding for MimeContentUTF8
                    return Encoding.UTF8.GetString(this.Content);
                }
                catch (ArgumentError)
                {
                    return Convert.ToBase64String(this.Content);
                }
            }
        }
        #endregion
    }
