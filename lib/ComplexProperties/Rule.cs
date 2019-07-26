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
    /// Represents a rule that automatically handles incoming messages.
    /// A rule consists of a set of conditions and exceptions that determine whether or
    /// not a set of actions should be executed on incoming messages.
    /// </summary>
 class Rule extends ComplexProperty
    {
        /// <summary>
        /// The rule ID.
        /// </summary>
        /* private */ String ruleId;

        /// <summary>
        /// The rule display name.
        /// </summary>
        /* private */ String displayName;

        /// <summary>
        /// The rule priority.
        /// </summary>
        /* private */ int priority;

        /// <summary>
        /// The rule status of enabled or not.
        /// </summary>
        /* private */ bool isEnabled;

        /// <summary>
        /// The rule status of is supported or not.
        /// </summary>
        /* private */ bool isNotSupported;

        /// <summary>
        /// The rule status of in error or not.
        /// </summary>
        /* private */ bool isInError;

        /// <summary>
        /// The rule conditions.
        /// </summary>
        /* private */ RulePredicates conditions;

        /// <summary>
        /// The rule actions.
        /// </summary>
        /* private */ RuleActions actions;

        /// <summary>
        /// The rule exceptions.
        /// </summary>
        /* private */ RulePredicates exceptions;

        /// <summary>
        /// Initializes a new instance of the <see cref="Rule"/> class.
        /// </summary>
 Rule()
            : super()
        {
            //// New rule has priority as 0 by default
            this.priority = 1;
            //// New rule is enabled by default
            this.isEnabled = true;
            this.conditions = new RulePredicates();
            this.actions = new RuleActions();
            this.exceptions = new RulePredicates();
        }

        /// <summary>
        /// Gets or sets the Id of this rule.
        /// </summary>
 String Id
        {
            get
            {
                return this.ruleId;
            }

            set
            {
                this.SetFieldValue<string>(ref this.ruleId, value);
            }
        }

        /// <summary>
        /// Gets or sets the name of this rule as it should be displayed to the user.
        /// </summary>
 String DisplayName
        {
            get
            {
                return this.displayName;
            }

            set
            {
                this.SetFieldValue<string>(ref this.displayName, value);
            }
        }

        /// <summary>
        /// Gets or sets the priority of this rule, which determines its execution order.
        /// </summary>
 int Priority
        {
            get
            {
                return this.priority;
            }

            set
            {
                this.SetFieldValue<int>(ref this.priority, value);
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this rule is enabled.
        /// </summary>
 bool IsEnabled
        {
            get
            {
                return this.isEnabled;
            }

            set
            {
                this.SetFieldValue<bool>(ref this.isEnabled, value);
            }
        }

        /// <summary>
        /// Gets a value indicating whether this rule can be modified via EWS.
        /// If IsNotSupported is true, the rule cannot be modified via EWS.
        /// </summary>
 bool IsNotSupported
        {
            get
            {
                return this.isNotSupported;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether this rule has errors. A rule that is in error
        /// cannot be processed unless it is updated and the error is corrected.
        /// </summary>
 bool IsInError
        {
            get
            {
                return this.isInError;
            }

            set
            {
                this.SetFieldValue<bool>(ref this.isInError, value);
            }
        }

        /// <summary>
        /// Gets the conditions that determine whether or not this rule should be
        /// executed against incoming messages.
        /// </summary>
 RulePredicates Conditions
        {
            get
            {
                return this.conditions;
            }
        }

        /// <summary>
        /// Gets the actions that should be executed against incoming messages if the
        /// conditions evaluate as true.
        /// </summary>
 RuleActions Actions
        {
            get
            {
                return this.actions;
            }
        }

        /// <summary>
        /// Gets the exceptions that determine if this rule should be skipped even if
        /// its conditions evaluate to true.
        /// </summary>
 RulePredicates Exceptions
        {
            get
            {
                return this.exceptions;
            }
        }

        /// <summary>
        /// Tries to read element from XML.
        /// </summary>
        /// <param name="reader">The reader.</param>
        /// <returns>True if element was read.</returns>
@override
        bool TryReadElementFromXml(EwsServiceXmlReader reader)
        {
            switch (reader.LocalName)
            {
                case XmlElementNames.DisplayName:
                    this.displayName = reader.ReadElementValue();
                    return true;
                case XmlElementNames.RuleId:
                    this.ruleId = reader.ReadElementValue();
                    return true;
                case XmlElementNames.Priority:
                    this.priority = reader.ReadElementValue<int>();
                    return true;
                case XmlElementNames.IsEnabled:
                    this.isEnabled = reader.ReadElementValue<bool>();
                    return true;
                case XmlElementNames.IsNotSupported:
                    this.isNotSupported = reader.ReadElementValue<bool>();
                    return true;
                case XmlElementNames.IsInError:
                    this.isInError = reader.ReadElementValue<bool>();
                    return true;
                case XmlElementNames.Conditions:
                    this.conditions.LoadFromXml(reader, reader.LocalName);
                    return true;
                case XmlElementNames.Actions:
                    this.actions.LoadFromXml(reader, reader.LocalName);
                    return true;
                case XmlElementNames.Exceptions:
                    this.exceptions.LoadFromXml(reader, reader.LocalName);
                    return true;
                default:
                    return false;
            }
        }

        /// <summary>
        /// Writes elements to XML.
        /// </summary>
        /// <param name="writer">The writer.</param>
@override
        void WriteElementsToXml(EwsServiceXmlWriter writer)
        {
            if (!StringUtils.IsNullOrEmpty(this.Id))
            {
                writer.WriteElementValue(
                    XmlNamespace.Types,
                    XmlElementNames.RuleId,
                    this.Id);
            }

            writer.WriteElementValue(
                XmlNamespace.Types,
                XmlElementNames.DisplayName,
                this.DisplayName);
            writer.WriteElementValue(
                XmlNamespace.Types,
                XmlElementNames.Priority,
                this.Priority);
            writer.WriteElementValue(
                XmlNamespace.Types,
                XmlElementNames.IsEnabled,
                this.IsEnabled);
            writer.WriteElementValue(
                XmlNamespace.Types,
                XmlElementNames.IsInError,
                this.IsInError);
            this.Conditions.WriteToXml(writer, XmlElementNames.Conditions);
            this.Exceptions.WriteToXml(writer, XmlElementNames.Exceptions);
            this.Actions.WriteToXml(writer, XmlElementNames.Actions);
        }

        /// <summary>
        /// Validates this instance.
        /// </summary>
@override
        void InternalValidate()
        {
            super.InternalValidate();
            EwsUtilities.ValidateParam(this.displayName, "DisplayName");
            EwsUtilities.ValidateParam(this.conditions, "Conditions");
            EwsUtilities.ValidateParam(this.exceptions, "Exceptions");
            EwsUtilities.ValidateParam(this.actions, "Actions");
        }
    }
