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
    /// Represents a ExecuteDiagnosticMethod request.
    /// </summary>
    class ExecuteDiagnosticMethodRequest extends MultiResponseServiceRequest<ExecuteDiagnosticMethodResponse>
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ExecuteDiagnosticMethodRequest"/> class.
        /// </summary>
        /// <param name="service">The service.</param>
        ExecuteDiagnosticMethodRequest(ExchangeService service)
            : super(service, ServiceErrorHandling.ThrowOnError)
        {
        }

        /// <summary>
        /// Gets the name of the XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetXmlElementName()
        {
            return XmlElementNames.ExecuteDiagnosticMethod;
        }

        /// <summary>
        /// Writes XML elements.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            writer.WriteElementValue(XmlNamespace.Messages, XmlElementNames.Verb, this.Verb);

            writer.WriteStartElement(XmlNamespace.Messages, XmlElementNames.Parameter);
            writer.WriteNode(this.Parameter);
            writer.WriteEndElement();
        }

        /// <summary>
        /// Gets the name of the response XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseXmlElementName()
        {
            return XmlElementNames.ExecuteDiagnosticMethodResponse;
        }

        /// <summary>
        /// Gets the request version.
        /// </summary>
        /// <returns>Earliest Exchange version in which this request is supported.</returns>
@override
        ExchangeVersion GetMinimumRequiredServerVersion()
        {

            // If it were marked for 2010_SP1, test cases would have to create new ExchangeService instances

            return ExchangeVersion.Exchange2007_SP1;
        }

        /// <summary>
        /// Gets or sets the verb of the method to execute.
        /// </summary>
        String Verb
        {
            get;
            set;
        }

        /// <summary>
        /// Gets or sets the parameter to the executing method.
        /// </summary>
        XmlNode Parameter
        {
            get;
            set;
        }

        /// <summary>
        /// Creates the service response.
        /// </summary>
        /// <param name="service">The service.</param>
        /// <param name="responseIndex">Index of the response.</param>
        /// <returns>Service response.</returns>
@override
        ExecuteDiagnosticMethodResponse CreateServiceResponse(ExchangeService service, int responseIndex)
        {
            return new ExecuteDiagnosticMethodResponse(service);
        }

        /// <summary>
        /// Gets the name of the response message XML element.
        /// </summary>
        /// <returns>XML element name,</returns>
@override
        String GetResponseMessageXmlElementName()
        {
            return XmlElementNames.ExecuteDiagnosticMethodResponseMEssage;
        }

        /// <summary>
        /// Gets the expected response message count.
        /// </summary>
        /// <returns>Number of expected response messages.</returns>
@override
        int GetExpectedResponseMessageCount()
        {
            return 1;
        }
    }
