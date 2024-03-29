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
    /// Represents mailbox hold status
    /// </summary>
 sealed class MailboxHoldStatus
    {
        /// <summary>
        /// Constructor
        /// </summary>
 MailboxHoldStatus()
        {
        }

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="mailbox">Mailbox</param>
        /// <param name="status">Hold status</param>
        /// <param name="additionalInfo">Additional info</param>
 MailboxHoldStatus(String mailbox, HoldStatus status, String additionalInfo)
        {
            Mailbox = mailbox;
            Status = status;
            AdditionalInfo = additionalInfo;
        }

        /// <summary>
        /// Mailbox
        /// </summary>
 String Mailbox { get; set; }

        /// <summary>
        /// Hold status
        /// </summary>
 HoldStatus Status { get; set; }

        /// <summary>
        /// Additional info
        /// </summary>
 String AdditionalInfo { get; set; }
    }

    /// <summary>
    /// Represents mailbox hold result
    /// </summary>
 sealed class MailboxHoldResult
    {
        /// <summary>
        /// Load from xml
        /// </summary>
        /// <param name="reader">The reader</param>
        /// <returns>Mailbox hold object</returns>
        static MailboxHoldResult LoadFromXml(EwsServiceXmlReader reader)
        {
            List<MailboxHoldStatus> statuses = new List<MailboxHoldStatus>();

            reader.ReadStartElement(XmlNamespace.Messages, XmlElementNames.MailboxHoldResult);

            MailboxHoldResult holdResult = new MailboxHoldResult();
            holdResult.HoldId = reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.HoldId);

            // the query could be empty means there won't be Query element, hence needs to read and check
            // if the next element is not Query, then it means already read MailboxHoldStatuses element
            await reader.Read();
            holdResult.Query = "";
            if (reader.IsStartElement(XmlNamespace.Types, XmlElementNames.Query))
            {
                holdResult.Query = reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.Query);
                reader.ReadStartElement(XmlNamespace.Types, XmlElementNames.MailboxHoldStatuses);
            }

            do
            {
                await reader.Read();
                if (reader.IsStartElement(XmlNamespace.Types, XmlElementNames.MailboxHoldStatus))
                {
                    String mailbox = reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.Mailbox);
                    HoldStatus status = (HoldStatus)Enum.Parse(typeof(HoldStatus), reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.Status));
                    String additionalInfo = reader.ReadElementValue(XmlNamespace.Types, XmlElementNames.AdditionalInfo);
                    statuses.Add(new MailboxHoldStatus(mailbox, status, additionalInfo));
                }
            }
            while (!reader.IsEndElement(XmlNamespace.Messages, XmlElementNames.MailboxHoldResult));

            holdResult.Statuses = statuses.Count == 0 ? null : statuses.ToArray();

            return holdResult;
        }

        /// <summary>
        /// Hold id
        /// </summary>
 String HoldId { get; set; }

        /// <summary>
        /// Query
        /// </summary>
 String Query { get; set; }

        /// <summary>
        /// Collection of mailbox status
        /// </summary>
 MailboxHoldStatus[] Statuses { get; set; }
    }
