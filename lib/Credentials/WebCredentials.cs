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
    /// WebCredentials wraps an instance of ICredentials used for password-based authentication schemes such as basic, digest, NTLM, and Kerberos authentication.
    /// </summary>
 class WebCredentials extends ExchangeCredentials
    {
        /* private */ ICredentials credentials;

        /// <summary>
        /// Initializes a new instance of the <see cref="WebCredentials"/> class to use
        /// the default network credentials.
        /// </summary>
 WebCredentials()
            : this(CredentialCache.DefaultNetworkCredentials)
        {
        }

        /// <summary>

        /// specified credentials.
        /// </summary>
        /// <param name="credentials">Credentials to use.</param>
 WebCredentials(ICredentials credentials)
        {
            EwsUtilities.ValidateParam(credentials, "credentials");

            this.credentials = credentials;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="WebCredentials"/> class.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
 WebCredentials(String username, String password)
            : this(new NetworkCredential(username, password))
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="WebCredentials"/> class.
        /// </summary>
        /// <param name="username">Account username.</param>
        /// <param name="password">Account password.</param>
        /// <param name="domain">Account domain.</param>
 WebCredentials(
            String username,
            String password,
            String domain)
            : this(new NetworkCredential(
                username,
                password,
                domain))
        {
        }

        /// <summary>
        /// Applies NetworkCredential associated with this instance to a service request.
        /// </summary>
        /// <param name="request">The request.</param>
@override
        void PrepareWebRequest(IEwsHttpWebRequest request)
        {
            request.Credentials = this.credentials;
        }

        /// <summary>
        /// Gets the Credentials from this instance.
        /// </summary>
        /// <value>The credentials.</value>
 ICredentials Credentials
        {
            get { return this.credentials; }
        }

        /// <summary>
        /// Adjusts the URL endpoint based on the credentials.
        /// For WebCredentials, the end user is responsible for setting the url.
        /// </summary>
        /// <param name="url">The URL.</param>
        /// <returns>The unchanged URL.</returns>
@override
        Uri AdjustUrl(Uri url)
        {
            return url;
        }
    }
